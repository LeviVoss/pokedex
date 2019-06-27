using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using PokeDex_lvoss.Models;
using System.IO;
using Microsoft.AspNet.Identity;

namespace PokeDex_lvoss.Controllers
{
    public class PokemonController : Controller
    {
        private PokeEDMX db = new PokeEDMX();

        // GET: Pokemon
        public ActionResult Index()
        {
            return View(db.Pokemons.ToList());
        }

        //GET: PokeDex
        public ActionResult PokeDexView(int pokeId = 1)
        {
            //get the file path
            //ViewBag.TotalTypes = db.Types.Count();
            //for (int i = 0; i > MyConstans.POKEMON_TYPES.Length; ++i)
            //{
            //    ViewBag.TypeCollectionImg = MyConstans.TYPE_IMAGE_PATH + db.Types.FirstOrDefault(x => x.typeName == MyConstans.POKEMON_TYPES[i] && x.typeId == i).typeImg;
            //    ViewBag.TypecollectionName = db.Types.FirstOrDefault(x => x.typeName == MyConstans.POKEMON_TYPES[i] && x.typeId == i).typeName;
            //}

            //make types
            ViewBag.types = db.Types.OrderBy(x => x.typeName).ToList();
            //get first pokemon hints
            ViewBag.hints = db.PokemonHints.Where(x => x.pokeId == pokeId);
            return View(db.Pokemons.FirstOrDefault(x => x.pokeId == pokeId));
        }

        //POST: PokeDex (sending pokemon)
        [HttpPost]
        public ActionResult FindPokemon(int pokeId, string whichPokemon)
        {
            Pokemon oldPokemon = db.Pokemons.FirstOrDefault(x => x.pokeId == pokeId);

            if (whichPokemon == "next")
            {
                //pokeId = pokeId + 1;
                Pokemon newPokemon = db.Pokemons.Where(x => x.pokeId > pokeId).AsEnumerable().SkipWhile(x => x.category == oldPokemon.category).FirstOrDefault();

                //display new pokemon hints
                var hints = db.PokemonHints.Where(x => x.pokeId == pokeId).Select(x => x.pokeHint);
                return Json(new { pokeHints = hints, pokemon = newPokemon, Img = Url.Content(MyConstans.POKEMON_IMAGE_PATH + newPokemon.pokeImgName) });
            }
            else if (whichPokemon == "prev")
            {
                //pokeId = pokeId - 1;
                Pokemon newPokemon = db.Pokemons.Where(x => x.pokeId < pokeId).AsEnumerable().SkipWhile(x => x.category == oldPokemon.category).FirstOrDefault();

                //display new pokemon hints
                var hints = db.PokemonHints.Where(x => x.pokeId == pokeId).Select(x => x.pokeHint);
                return Json(new { pokeHints = hints, pokemon = newPokemon, Img = Url.Content(MyConstans.POKEMON_IMAGE_PATH + newPokemon.pokeImgName) });
            }
            else if (whichPokemon == "up")
            {
                pokeId = pokeId + 1;
                Pokemon newPokemon = db.Pokemons.Where(x => x.category == oldPokemon.category).FirstOrDefault(x => x.pokeId == pokeId);

                //display new pokemon hints
                var hints = db.PokemonHints.Where(x => x.pokeId == pokeId).Select(x => x.pokeHint);
                return Json(new { pokeHints = hints, pokemon = newPokemon, Img = Url.Content(MyConstans.POKEMON_IMAGE_PATH + newPokemon.pokeImgName) });
            }
            else if (whichPokemon == "down")
            {
                pokeId = pokeId - 1;
                Pokemon newPokemon = db.Pokemons.Where(x => x.category == oldPokemon.category).FirstOrDefault(x => x.pokeId == pokeId);

                //display new pokemon hints
                var hints = db.PokemonHints.Where(x => x.pokeId == pokeId).Select(x => x.pokeHint);
                return Json(new { pokeHints = hints, pokemon = newPokemon, Img = Url.Content(MyConstans.POKEMON_IMAGE_PATH + newPokemon.pokeImgName) });
            }
            //get new selected pokemon
            //Pokemon newPokemon = db.Pokemons.FirstOrDefault(x => x.pokeId == pokeId);
            //display new pokemon hints
            //var hints = db.PokemonHints.Where(x => x.pokeId == pokeId).Select(x => x.pokeHint);
            return Json(new { });
        }

        //POST: Pokedex (adding hints)
        [HttpPost]
        public ActionResult AddHint(int currPokeId, string currName, string currHint)
        {
            try
            {
                //add hint to db
                PokemonHint newHint = new PokemonHint
                {
                    hintId = Guid.NewGuid(),
                    pokeName = currName,
                    userId = Guid.Parse(User.Identity.GetUserId()),
                    pokeHint = currHint,
                    pokeId = currPokeId,
                };
                db.PokemonHints.Add(newHint);
                db.SaveChanges();
            }
            catch (Exception)
            {
                ModelState.AddModelError("newHint", $"Failed to make a new hint for {currName}.");
            }

            //return og pokemon and updated hints
            ViewBag.hints = db.PokemonHints.Where(x => x.pokeName == currName);
            Pokemon newPokemon = db.Pokemons.FirstOrDefault(x => x.pokeId == currPokeId);

            return Json(new { pokemon = newPokemon, Img = Url.Content(MyConstans.POKEMON_IMAGE_PATH + newPokemon.pokeImgName) });
        }

        private void UploadPokemonImage(Pokemon pokemon, HttpPostedFileBase file)
        {
            //Make webImage
            WebImage img = new WebImage(file.InputStream);

            //Resize img
            img.Resize(MyConstans.POKEMON_IMAGE_SIZE, MyConstans.POKEMON_IMAGE_SIZE);

            //Save img
            string fileName = file.FileName;
            img.Save(Path.Combine(MyConstans.POKEMON_IMAGE_PATH, fileName));

            //Save img to db
            pokemon.pokeImgName = fileName;
        }

        private bool ValidateImage(string key, HttpPostedFileBase file)
        {
            // Check the the image file isn't to small or too big
            if (file.ContentLength <= 0)
            {
                ModelState.AddModelError(key, "File size was zero");
                return false;
            }

            if (file.ContentLength > MyConstans.MAX_IMAGE_FILE_SIZE)
            {
                ModelState.AddModelError(key, $"File was bigger than {MyConstans.MAX_IMAGE_FILE_SIZE} bytes.");
                return false;
            }

            // Check that the image has the proper extension
            string fileExtension = System.IO.Path.GetExtension(file.FileName).ToLower();
            if (MyConstans.ALLOWED_IMG_EXTENSION != fileExtension)
            {
                ModelState.AddModelError(key, $"File extension {fileExtension} not allowed.");
                return false;
            }

            return true;
        }

        private void UploadImage(
            HttpPostedFileBase file,
            string destinationFolder,
            string filename,
            int maxWidth,
            int maxHeight)
        {
            // Save the image
            WebImage img = new WebImage(file.InputStream);
            if (img.Width > maxWidth || img.Height > maxHeight)
            {
                img.Resize(maxWidth, maxHeight);
            }
            img.Save(destinationFolder + filename);
        }

        // GET: Pokemon/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pokemon pokemon = db.Pokemons.Find(id);
            if (pokemon == null)
            {
                return HttpNotFound();
            }
            return View(pokemon);
        }

        // GET: Pokemon/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Pokemon/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "pokeId,pokemonName,type,weakness,height,weight,gender,category,pokeImgName,evolution,maxEvo")]
        Pokemon pokemon,
        HttpPostedFileBase pokemonUpload)
        {
            try
            {
                if (pokemonUpload != null &&
                        ValidateImage("pokemonUpload", pokemonUpload))
                {
                    UploadPokemonImage(pokemon, pokemonUpload);
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("pokemonImgName", "Failed to save Pokemon Image:" + ex.Message);
            }

            try
            {
                if (ModelState.IsValid)
                {
                    db.Pokemons.Add(pokemon);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("pokemon", "failed to create");
            }

            return View(pokemon);
        }

        // GET: Pokemon/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pokemon pokemon = db.Pokemons.Find(id);
            if (pokemon == null)
            {
                return HttpNotFound();
            }
            return View(pokemon);
        }

        // POST: Pokemon/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "pokeId,pokemonName,type,weakness,height,weight,gender,category,pokeImgName,evolution,maxEvo")]
        Pokemon pokemon,
        HttpPostedFileBase pokemonUpload)
        {
            try
            {
                if (pokemonUpload != null &&
                    ValidateImage("pokemonUpload", pokemonUpload))
                {
                    UploadPokemonImage(pokemon, pokemonUpload);
                }
            }
            catch(Exception ex)
            {
                ModelState.AddModelError("pokemonImgName", "Failed to save Pokemon Image! " + ex.Message);
            }

            try
            {
                if (ModelState.IsValid)
                {
                    db.Entry(pokemon).State = EntityState.Modified;
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("pokemon", "Failed to create Pokemon");
            }
            return View(pokemon);
        }

        // GET: Pokemon/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pokemon pokemon = db.Pokemons.Find(id);
            if (pokemon == null)
            {
                return HttpNotFound();
            }
            return View(pokemon);
        }

        // POST: Pokemon/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Pokemon pokemon = db.Pokemons.Find(id);
            db.Pokemons.Remove(pokemon);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}

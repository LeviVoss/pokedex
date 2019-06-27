using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(PokeDex_lvoss.Startup))]
namespace PokeDex_lvoss
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}

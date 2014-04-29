MIME-Version: 1.0
In-Reply-To: <2dfe2833a247d602a0038d28a3636a6d74bd1845.1393620082.git.luto@amacapital.net>
References: <CALCETrXs6o0t5hJutE-uz4a7q8eGqRuhCXwJwbog4B606P0+pw@mail.gmail.com>
	<2dfe2833a247d602a0038d28a3636a6d74bd1845.1393620082.git.luto@amacapital.net>
Date: Tue, 29 Apr 2014 09:33:36 -0300
Message-ID: <CAKi4VA+gdJjYgQcvykTF70AH1YvqA=EmT4xZPZgjRz5mXww4zw@mail.gmail.com>
Subject: Re: [PATCH] Add --moddir to depmod and modprobe to override the
 target directory
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Andy,

sorry for taking so long to reply

On Fri, Feb 28, 2014 at 5:43 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> Currently, depmod and modprobe can only use directories of the form
> ROOT/lib/modules/VERSION, where ROOT and VERSION can be specified on
> the command line.  Additionally, when used with explicitly-listed
> modules depmod requires absolute paths, making it difficult to
> generate a nonstandard module layout without symlink hacks and
> absolute paths.
>
> This lifts both restrictions with a new --moddir option.  --moddir
> specifies an exact directory name and, when --moddir is used, depmod
> will accept relative module paths on the command line.
>
> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
> ---

First the reasoning why we still don't have something like this:

I was trying to avoid adding new options to modprobe/depmod. My hope
was to finish the tool interface so they could share command options.
It's already a mess between modprobe and depmod (--dirname vs
--basedir, -S vs positional arg).

And now a new option... incompatible with the previous 2 to operate in
the same string.

However I realize the usefulness of this option. It's intended for
people developing modules, right? So you don't have to install it and
can run depmod/modprobe on the local dir. What if you depend on
another module? That dependency won't be satisfied and you will need
to start copying other modules to your "staging" dir. Is this really
the use-case? I can't imagine another one.


About the patch, I think it's a bit intrusive. It should just operate
on the base prefix like --dirname does. Why does it need to do so many
things like copying strings around, changing dir, etc? See below.

>  man/depmod.xml   | 29 +++++++++++++++++++++++++++++
>  man/modprobe.xml | 18 ++++++++++++++++++
>  tools/depmod.c   | 56 ++++++++++++++++++++++++++++++++++++++++++++------------
>  tools/modprobe.c | 16 ++++++++++++++++
>  4 files changed, 107 insertions(+), 12 deletions(-)

[ ... ]

> diff --git a/tools/depmod.c b/tools/depmod.c
> index b1b5874..5cba93b 100644
> --- a/tools/depmod.c
> +++ b/tools/depmod.c
> @@ -48,6 +48,9 @@ static const char *default_cfg_paths[] = {
>         NULL
>  };
>
> +enum LONGOPTS {
> +       MODDIR_OPT = 1000,
> +};
>  static const char cmdopts_s[] = "aAb:C:E:F:euqrvnP:wmVh";
>  static const struct option cmdopts[] = {
>         { "all", no_argument, 0, 'a' },
> @@ -66,6 +69,7 @@ static const struct option cmdopts[] = {
>         { "symbol-prefix", required_argument, 0, 'P' },
>         { "warn", no_argument, 0, 'w' },
>         { "map", no_argument, 0, 'm' }, /* deprecated */
> +       { "moddir", required_argument, 0, MODDIR_OPT },
>         { "version", no_argument, 0, 'V' },
>         { "help", no_argument, 0, 'h' },
>         { }
> @@ -94,6 +98,8 @@ static void help(void)
>                 "\n"
>                 "The following options are useful for people managing distributions:\n"
>                 "\t-b, --basedir=DIR    Use an image of a module tree.\n"
> +               "\t--moddir=MODDIR      Specify a target directory and allow relative\n"
> +               "\t                     paths.  Do not use -b or specify a version.\n"
>                 "\t-F, --filesyms=FILE  Use the file instead of the\n"
>                 "\t                     current kernel symbols.\n"
>                 "\t-E, --symvers=FILE   Use Module.symvers file to check\n"
> @@ -1045,7 +1051,8 @@ static void depmod_shutdown(struct depmod *depmod)
>         kmod_unref(depmod->ctx);
>  }
>
> -static int depmod_module_add(struct depmod *depmod, struct kmod_module *kmod)
> +static int depmod_module_add(struct depmod *depmod, struct kmod_module *kmod,
> +                            const char *relpath)

this parameter should not exist

>  {
>         const struct cfg *cfg = depmod->cfg;
>         const char *modname, *lastslash;
> @@ -1070,11 +1077,14 @@ static int depmod_module_add(struct depmod *depmod, struct kmod_module *kmod)
>         mod->path = strdup(kmod_module_get_path(kmod));
>         lastslash = strrchr(mod->path, '/');
>         mod->baselen = lastslash - mod->path;
> -       if (strncmp(mod->path, cfg->dirname, cfg->dirnamelen) == 0 &&
> -                       mod->path[cfg->dirnamelen] == '/')

cfg->dirname should rather contain the right prefix already, so this
change wouldn't be needed.

> +       if (relpath) {
> +               mod->relpath = strdup(relpath);

Because of the way you passed relpath in, here you leak mod->relpath.
In the "else if" below we just point mod->relpath to the right portion
of the string, we don't copy it.

> +       } else if (strncmp(mod->path, cfg->dirname, cfg->dirnamelen) == 0 &&
> +                       mod->path[cfg->dirnamelen] == '/') {
>                 mod->relpath = mod->path + cfg->dirnamelen + 1;
> -       else
> +       } else {
>                 mod->relpath = NULL;
> +       }
>
>         err = hash_add_unique(depmod->modules_by_name, mod->modname, mod);
>         if (err < 0) {
> @@ -1082,7 +1092,7 @@ static int depmod_module_add(struct depmod *depmod, struct kmod_module *kmod)
>                 goto fail;
>         }
>
> -       if (mod->relpath != NULL) {
> +       if (mod->relpath != NULL && !relpath) {
>                 size_t uncrelpathlen = lastslash - mod->relpath + modnamelen
>                                        + kmod_exts[KMOD_EXT_UNC].len;
>                 mod->uncrelpath = memdup(mod->relpath, uncrelpathlen + 1);
> @@ -1221,7 +1231,7 @@ add:
>                 return err;
>         }
>
> -       err = depmod_module_add(depmod, kmod);
> +       err = depmod_module_add(depmod, kmod, NULL);

so this only work for modules in the command line? Confusing, I
thought you wanted something like:

depmod -a --moddir .

And let depmod do its job on the local dir instead of $root/lib/modules/$kver


>         if (err < 0) {
>                 ERR("could not add module %s: %s\n",
>                     path, strerror(-err));
> @@ -2467,6 +2477,7 @@ static int do_depmod(int argc, char *argv[])
>         const char *system_map = NULL;
>         const char *module_symvers = NULL;
>         const char *null_kmod_config = NULL;
> +       const char *moddir = NULL;
>         struct utsname un;
>         struct kmod_ctx *ctx = NULL;
>         struct cfg cfg;
> @@ -2540,6 +2551,9 @@ static int do_depmod(int argc, char *argv[])
>                                 WRN("Ignored deprecated option -%c\n", c);
>
>                         break;
> +               case MODDIR_OPT:
> +                       moddir = optarg;
> +                       break;
>                 case 'h':
>                         help();
>                         free(config_paths);
> @@ -2556,7 +2570,14 @@ static int do_depmod(int argc, char *argv[])
>                 }
>         }
>
> -       if (optind < argc && is_version_number(argv[optind])) {
> +       if (moddir && root) {
> +               ERR("--moddir and -b cannot be used together.\n");
> +               goto cmdline_failed;
> +       }
> +
> +       if (moddir) {
> +               cfg.kversion = NULL;
> +       } else if (optind < argc && is_version_number(argv[optind])) {
>                 cfg.kversion = argv[optind];
>                 optind++;
>         } else {
> @@ -2567,9 +2588,20 @@ static int do_depmod(int argc, char *argv[])
>                 cfg.kversion = un.release;
>         }
>
> -       cfg.dirnamelen = snprintf(cfg.dirname, PATH_MAX,
> -                                 "%s/lib/modules/%s",
> -                                 root == NULL ? "" : root, cfg.kversion);
> +       if (moddir) {
> +               if (chdir(moddir) != 0) {
> +                       CRIT("chdir(%s): %s\n", moddir, strerror(errno));
> +                       goto cmdline_failed;
> +               }

why? just set cfg.dirname and it should work

> +
> +               strcpy(cfg.dirname, ".");
> +               cfg.dirnamelen = 1;
> +       } else {
> +               cfg.dirnamelen = snprintf(cfg.dirname, PATH_MAX,
> +                                         "%s/lib/modules/%s",

IMO this is the string you should be changing, to allow for anything else


-- 
Lucas De Marchi

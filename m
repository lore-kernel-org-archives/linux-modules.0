Return-Path: <caio.oliveira@intel.com>
Date: Sat, 7 Mar 2015 10:39:40 -0300
From: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 3/3] tools: add basic versions of insert and remove
Message-ID: <20150307133940.GA938@gray.amr.corp.intel.com>
References: <1425571599-26032-1-git-send-email-caio.oliveira@intel.com>
 <1425571599-26032-3-git-send-email-caio.oliveira@intel.com>
 <CAKi4VAKWR=4-dX3u5UciAjLnQYgKdQQ+=MuY44GCC42d+ERm2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKi4VAKWR=4-dX3u5UciAjLnQYgKdQQ+=MuY44GCC42d+ERm2w@mail.gmail.com>
List-ID: <linux-modules.vger.kernel.org>

Thanks! Pushed a new version of the patch fixing the minor issues.


On Fri, Mar 06, 2015 at 12:23:29AM -0300, Lucas De Marchi wrote:
> Overall it's nice, but I have some comments on this one. See below
> > +DEFINE_TEST(kmod_tool_insert,
> > +       .description = "check kmod insert",
> > +       .config = {
> > +               [TC_UNAME_R] = "4.4.4",
> > +               [TC_ROOTFS] = TESTSUITE_ROOTFS "test-tools/insert",
> > +               [TC_INIT_MODULE_RETCODES] = "",
> 
> are these and other similar ones  correct? why do you need to set it
> to an empty string?

If TC_INIT_MODULE_RETCODES is NULL, the preload for init_module won't
be loaded, so we need it set.

When set, it will automatically succeed loading any non-builtin
modules, except those mentioned in the string, that will succeed or
not depending on the error code.

Same approach is taken by TC_DELETE_MODULE_RETCODES.


> > +       kmod_list_foreach(l, list) {
> > +               struct kmod_module *mod = kmod_module_get_module(l);
> > +
> > +               err = kmod_module_probe_insert_module(mod, KMOD_PROBE_APPLY_BLACKLIST, NULL, NULL, NULL, NULL);
> > +               if (err != 0)
> > +                       ERR("Could not insert '%s': %s\n", kmod_module_get_name(mod), mod_strerror(err));
> > +
> > +               kmod_module_unref(mod);
> 
> missing 1 unref() in the error path. Just reorder the error check with
> the unref() and you'll be fine.

ERR() doesn't return or break, each get_module() will have a
corresponding unref() call.

I've ended up rewriting the return code handling to ensure that if one
of the insertions fail, return code will be EXIT_FAILURE.


Cheers,
Caio

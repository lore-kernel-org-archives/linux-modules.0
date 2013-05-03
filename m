Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-qe0-f41.google.com ([209.85.128.41]:64814 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762390Ab3ECCsD (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 2 May 2013 22:48:03 -0400
Received: by mail-qe0-f41.google.com with SMTP id b10so686502qen.28
        for <linux-modules@vger.kernel.org>; Thu, 02 May 2013 19:48:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1367501008-10459-1-git-send-email-johannes@sipsolutions.net>
References: <1367501008-10459-1-git-send-email-johannes@sipsolutions.net>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 2 May 2013 23:47:41 -0300
Message-ID: <CAMOw1v7cpGCxWKOstCf-h6mMVe9Op18BU-E_nvR4FnKmedrHgA@mail.gmail.com>
Subject: Re: [PATCH] modprobe: don't check refcount with remove command
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	david.spinadel@intel.com, Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi Johannes,

On Thu, May 2, 2013 at 10:23 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> The modprobe.d (5) documentation for the "install" command
> states that you could specify
>
> install fred /sbin/modprobe barney; /sbin/modprobe --ignore-install fred
>
> This makes some sense, but then the loading of "barney" is
> hidden from the user who did only "modprobe fred". Thus,
> it seems it should be possible to be able to unload the
> "fred" module with "modprobe -r fred" by configuring the
> "barney" module to also be removed:
>
> remove fred /sbin/rmmod barney fred
>
> (or similar.)
>
> Make this possible by not checking the refcount when an
> unload command was configured.
>
> Reported-by: David Spinadel <david.spinadel@intel.com>
> ---
>  tools/modprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/modprobe.c b/tools/modprobe.c
> index a053efb..6b34658 100644
> --- a/tools/modprobe.c
> +++ b/tools/modprobe.c
> @@ -386,7 +386,7 @@ static int rmmod_do_module(struct kmod_module *mod, bool do_dependencies)
>                         goto error;
>         }
>
> -       if (!ignore_loaded) {
> +       if (!ignore_loaded && !cmd) {
>                 int usage = kmod_module_get_refcnt(mod);
>
>                 if (usage > 0) {
> --

Thanks, patch has been applied.

However.... I'd like to strongly advise not to use install/remove
commands for simple dependencies like this. It's much simpler and
faster both for kmod and for who is configuring to use softdeps. Your
example could be very well replace with the single line below:

softdep fred pre: barney

I think we need a better explanation on man page and even remove this
example from there. Install/remove commands are only there because of
the legacy stuff that would stop working otherwise.

Anyway... thanks for catching this.

Lucas De Marchi

Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:39358 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbaBQNrF (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 17 Feb 2014 08:47:05 -0500
Received: by mail-oa0-f44.google.com with SMTP id g12so17731687oah.3
        for <linux-modules@vger.kernel.org>; Mon, 17 Feb 2014 05:47:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140216222340.153307f5@gentp.lnet>
References: <20140216222340.153307f5@gentp.lnet>
Date: Mon, 17 Feb 2014 08:47:05 -0500
Message-ID: <CA+5PVA417O+uny=q5yZk22gVZi2zojrUGHQrq05XuXDUSW_KgA@mail.gmail.com>
Subject: Re: Proposal: Add a depmod wrapper for kmod to aid SELinux
From: Josh Boyer <jwboyer@fedoraproject.org>
To: Luis Ressel <aranea@aixah.de>
Cc: "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Sun, Feb 16, 2014 at 4:23 PM, Luis Ressel <aranea@aixah.de> wrote:
> Hello,
>
>
> I've got a small proposal for kmod which would be helpful for SELinux
> users. First of all, I'll give some background (if you're not
> interested in that, you can skip the next two paragraphs):
>
> As you may know, SELinux is is an optional kernel subsystem which gives
> finer control over permissions than the standard Unix DAC
> (Discretionary Access Controls - the normal read/write/execute bits).
> Basically, it attaches labels ("contexts") to files and processes and
> bases the decision whether to allow or not to allow a specific action
> upon these contexts.
>
> For multi-call binaries like kmod, this labeling is problematic: The
> kmod tool "depmod" requires a different set of permissions than the
> rest of the kmod tools, and should therefore get a different label.
> However, all of the kmod tools are only symlinks to /bin/kmod - and due
> to technical limitations, we can only attach labels to files, but not to
> symlinks.

Can you elaborate on the different set of SELinux labels/permissions
for depmod?  Fedora ships with SELinux enforcing enabled and we've not
had any issues with depmod being under the system_u:object_r:bin_t:s0
label.  I'm curious what you're trying to set depmod to and why.

> Thus, it would be useful if you could add wrapper binary to the kmod
> distribution, basically just an
> "execl("/bin/kmod", "/sbin/depmod", NULL);" call. This would behave
> exactly the same as a symlink, but would allow SELinux policies to
> label that binary differently. Of course, this doesn't have to be
> done for every user; it could be optional on a ./configure option
> "--enable-depmod-wrapper".
>
> What do you think? Would you accept such a patch?

This seems somewhat over-engineered.  Wouldn't it be simpler to copy
the kmod binary itself to a real file called 'depmod' during the
installation?

josh

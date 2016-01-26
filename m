Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51006 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632AbcAZUsV (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Tue, 26 Jan 2016 15:48:21 -0500
Date: Tue, 26 Jan 2016 21:48:18 +0100
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dave Young <dyoung@redhat.com>,
	linux-security-module@vger.kernel.org,
	Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	kexec@lists.infradead.org, David Howells <dhowells@redhat.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	linux-modules@vger.kernel.org
Subject: Re: [RFC PATCH v2 06/11] kexec: replace call to copy_file_from_fd()
 with kernel version
Message-ID: <20160126204818.GJ20964@wotan.suse.de>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-7-git-send-email-zohar@linux.vnet.ibm.com>
 <20160125063712.GC5616@dhcp-128-65.nay.redhat.com>
 <1453734258.2713.4.camel@linux.vnet.ibm.com>
 <20160125203414.GE20964@wotan.suse.de>
 <1453765692.2803.15.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453765692.2803.15.camel@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jan 25, 2016 at 06:48:12PM -0500, Mimi Zohar wrote:
> On Mon, 2016-01-25 at 21:34 +0100, Luis R. Rodriguez wrote:
> > On Mon, Jan 25, 2016 at 10:04:18AM -0500, Mimi Zohar wrote:
> > > On Mon, 2016-01-25 at 14:37 +0800, Dave Young wrote:
> > > > Hi, Mimi
> > > > 
> > > > Besides of code issues, I have several thing to be understand:
> > > > 
> > > > What is the effect to kexec behavior with this patchset?
> > > >   - without IMA enabled (kconfig or kernel cmdline) it will be same as before?
> > > 
> > > Yes, without IMA configured or an IMA policy, it is the same as before.
> > 
> > That's a bit unfair to your work here, this actually paves the way
> > for not only IMA but also other LSMs to vet for the kexec/initramfs
> > given LSM hooks are used now on a common kernel read set of functions.
> 
> Right, I responded to his questions about IMA and not the bigger picture.

Indeed, its just the bigger picture helps validate your work further.

> > > >   - with IMA enabled for kernel bzImage, kexec_file_load will check both ima
> > > >     signature and original pe file signature, those two mechanisms are
> > > >     somehow duplicated. I'm not sure if we need both for bzImage.
> > > 
> > > IMA provides a uniform method of measuring and appraising all files on
> > > the system, based on policy.  The IMA policy could prevent the original
> > > kexec syscall. 
> 
> Sorry for jumping back and forth between security hooks.  Similarly, for
> the kernel module hook, it prevents the original kernel module syscall
> as well.

This is indeed an important feature. I know people who don't use IMA won't
care, but people who do should, likewise its also important for the prospects
in design of LSMs if they wanted to consider the prospects of this evaluation
for any of the file types we are now clearly defining.

> > On systems without MODULE_SIG_FORCE, the IMA policy
> > > would require an IMA signature as well.  (The current patch would
> > > require both, even when MODULE_SIG_FORCE is enabled.)
> > 
> > 
> > Right, so what this approach has revealed really is that architecturally
> > MODULE_SIG_FORCE should have been an LSM but its not, its also hard to make it
> > an LSM.  Now with LSM stacking this might make more sense but that requires
> > work and who knows when and if that will happen. 
> 
> I kind of lost you here.  A new mini LSM would require file signatures
> of an existing type or would it be a new method for verifying file
> signatures?

No the way I see it is this is a feature for signature verification with all
security mechanisms built-in to the kernel. Clearly there is a difference for
how signatures are defined between file types: modules have signatures built-in
to the file, meanwhile for other files this might be detached (that will be the
case for firmware, sysdata). This has yet to be considered for kexec /
initramfs but it shouldn't' be too hard now to consider that. Its also why
firmware signatures is using a separate kconfig option.

> > In the meantime we'll live
> > with the fact that enabling MODULE_SIG_FORCE means you want to stack on
> > top of the LSMs you have enabled, the MODULE_SIG_FORCE functionality being
> > all kernel related and perhaps easier to manage / set.
> 
> As I see it, with MODULE_SIG_FORCE, IMA-appraisal could relax its own
> policy knowing that only signed kernel modules are loaded.  Without
> MODULE_SIG_FORCE enabled, then IMA-appraisal needs to do the enforcing,
> of course based on policy.

Sure, up to the LSMs, which begs the question of how an LSM would codify
such stacking assumptions. IIRC stacking will just let the code stack, but
I am not sure if we have a clean way to know: hey the kernel vetted this
file's signature itself, just fyi. Other than #idef'ery or relying on the
.config.  What I just described is the case for say IMA and kernel module
firmware signing (note both have separate kconfigs), the same question still
applies to ways LSM stacking can provide a set of security requirements each
could have addressed. All in a clean way.

  Luis

Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:54666 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932859AbcAYXtL (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 25 Jan 2016 18:49:11 -0500
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Tue, 26 Jan 2016 09:49:09 +1000
Message-ID: <1453765692.2803.15.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 06/11] kexec: replace call to copy_file_from_fd()
 with kernel version
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Dave Young <dyoung@redhat.com>,
	linux-security-module@vger.kernel.org,
	Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	kexec@lists.infradead.org, David Howells <dhowells@redhat.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	linux-modules@vger.kernel.org
Date: Mon, 25 Jan 2016 18:48:12 -0500
In-Reply-To: <20160125203414.GE20964@wotan.suse.de>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1453129886-20192-7-git-send-email-zohar@linux.vnet.ibm.com>
	 <20160125063712.GC5616@dhcp-128-65.nay.redhat.com>
	 <1453734258.2713.4.camel@linux.vnet.ibm.com>
	 <20160125203414.GE20964@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Mon, 2016-01-25 at 21:34 +0100, Luis R. Rodriguez wrote:
> On Mon, Jan 25, 2016 at 10:04:18AM -0500, Mimi Zohar wrote:
> > On Mon, 2016-01-25 at 14:37 +0800, Dave Young wrote:
> > > Hi, Mimi
> > > 
> > > Besides of code issues, I have several thing to be understand:
> > > 
> > > What is the effect to kexec behavior with this patchset?
> > >   - without IMA enabled (kconfig or kernel cmdline) it will be same as before?
> > 
> > Yes, without IMA configured or an IMA policy, it is the same as before.
> 
> That's a bit unfair to your work here, this actually paves the way
> for not only IMA but also other LSMs to vet for the kexec/initramfs
> given LSM hooks are used now on a common kernel read set of functions.

Right, I responded to his questions about IMA and not the bigger picture.

> > 
> > >   - with IMA enabled for kernel bzImage, kexec_file_load will check both ima
> > >     signature and original pe file signature, those two mechanisms are
> > >     somehow duplicated. I'm not sure if we need both for bzImage.
> > 
> > IMA provides a uniform method of measuring and appraising all files on
> > the system, based on policy.  The IMA policy could prevent the original
> > kexec syscall. 

Sorry for jumping back and forth between security hooks.  Similarly, for
the kernel module hook, it prevents the original kernel module syscall
as well.

> On systems without MODULE_SIG_FORCE, the IMA policy
> > would require an IMA signature as well.  (The current patch would
> > require both, even when MODULE_SIG_FORCE is enabled.)
> 
> 
> Right, so what this approach has revealed really is that architecturally
> MODULE_SIG_FORCE should have been an LSM but its not, its also hard to make it
> an LSM.  Now with LSM stacking this might make more sense but that requires
> work and who knows when and if that will happen. 

I kind of lost you here.  A new mini LSM would require file signatures
of an existing type or would it be a new method for verifying file
signatures?

> In the meantime we'll live
> with the fact that enabling MODULE_SIG_FORCE means you want to stack on
> top of the LSMs you have enabled, the MODULE_SIG_FORCE functionality being
> all kernel related and perhaps easier to manage / set.

As I see it, with MODULE_SIG_FORCE, IMA-appraisal could relax its own
policy knowing that only signed kernel modules are loaded.  Without
MODULE_SIG_FORCE enabled, then IMA-appraisal needs to do the enforcing,
of course based on policy.

Mimi


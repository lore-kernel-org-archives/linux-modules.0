Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45095 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268AbcAZBUs (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 25 Jan 2016 20:20:48 -0500
Date: Tue, 26 Jan 2016 09:20:31 +0800
From: Dave Young <dyoung@redhat.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module@vger.kernel.org,
	Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	kexec@lists.infradead.org, David Howells <dhowells@redhat.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	linux-modules@vger.kernel.org
Subject: Re: [RFC PATCH v2 06/11] kexec: replace call to copy_file_from_fd()
 with kernel version
Message-ID: <20160126012031.GA3228@dhcp-128-65.nay.redhat.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-7-git-send-email-zohar@linux.vnet.ibm.com>
 <20160125063712.GC5616@dhcp-128-65.nay.redhat.com>
 <1453734258.2713.4.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453734258.2713.4.camel@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi, Mimi

On 01/25/16 at 10:04am, Mimi Zohar wrote:
> On Mon, 2016-01-25 at 14:37 +0800, Dave Young wrote:
> > Hi, Mimi
> > 
> > Besides of code issues, I have several thing to be understand:
> > 
> > What is the effect to kexec behavior with this patchset?
> >   - without IMA enabled (kconfig or kernel cmdline) it will be same as before?
> 
> Yes, without IMA configured or an IMA policy, it is the same as before.
> 
> >   - with IMA enabled for kernel bzImage, kexec_file_load will check both ima
> >     signature and original pe file signature, those two mechanisms are
> >     somehow duplicated. I'm not sure if we need both for bzImage.
> 
> IMA provides a uniform method of measuring and appraising all files on
> the system, based on policy.  The IMA policy could prevent the original
> kexec syscall.  On systems without MODULE_SIG_FORCE, the IMA policy
> would require an IMA signature as well.  (The current patch would
> require both, even when MODULE_SIG_FORCE is enabled.)

Hmm, enabling policy is in userspace (initramfs?) so it may not be good
enough for secure boot case. IMA can be used as a uniform method for kexec
kernel signature verification for !UEFI or !secure-boot case. 

> 
> The pe format is supported on x86.  Why require the pe file signature
> format on all platforms?

For secure boot purpose, an uefi bootable kernel (as an uefi applicatioin)
require it to be a pe file.

But for !secure-boot it is not mandatory.

> 
> > Do you have a simple usage documentation about how to test it?
> 
> The wiki[1] and ima-evm-ctl package[2] have directions for enabling
> IMA/IMA-appraisal.
> 
> To include just the kexec image and initramfs file hashes in the IMA
> measurement list, create a file containing the following IMA policy
> rules.  "cat" the policy and redirect the output
> to /sys/kernel/security/ima/policy.   After loading the kexec image and
> initramfs, the IMA measurements will be included in the measurement list
> (/sys/kernel/security/ima/ascii_runtime_measurements)
> 
> IMA policy: 
> measure func=KEXEC_CHECK
> measure func=INITRAMFS_CHECK
> 
> Appraising the kexec image and initramfs is a bit more complicated as it
> requires creating a key, which is signed by a key on the system keyring,
> and loading the key onto the trusted IMA keyring.  To simplify testing,
> without CONFIG_IMA_TRUSTED_KEYRING enabled, the key being loaded onto
> the IMA keyring does not need to be signed.  The evmctl man page[2]
> contains directions for creating and loading the key onto the IMA
> keyring. 
> 
> To appraise just the kexec image and initramfs files, add the following
> two rules to the IMA policy and load the policy as before.  (The policy
> can only be loaded once per boot, unless IMA_WRITE_POLICY is configured.
> With the default appraisal policy, the policy would need to signed.)
> Sign the kexec image and initramfs with evmctl before loading them.
> 
> # evmctl ima_sign -k <private key> -a sha256 <VM image>
> # evmctl ima_sign -k <private key> -a sha256 <initramfs>
> 
> IMA appraise policy:
> appraise func=KEXEC_CHECK appraise_type=imasig
> appraise func=INITRAMFS_CHECK appraise_type=imasig
> 
> [1] http://sourceforge.net/p/linux-ima/wiki/Home
> [2] http://linux-ima.sourceforge.net/evmctl.1.html

Thank you, will try

> 
> > > +{
> > > +	struct fd f = fdget(fd);
> > > +	int ret = -ENOEXEC;
> > 
> > -EBADF looks better?
> 
> Sure.
> 

Seems you missed another comment about the policy id name?
can the name be like below?
KEXEC_KERNEL_CHECK
KEXEC_INITRAMFS_CHECK

Thanks
Dave

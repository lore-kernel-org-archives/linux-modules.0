Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:57601 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbcBLNKH (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 12 Feb 2016 08:10:07 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Fri, 12 Feb 2016 23:10:04 +1000
Message-ID: <1455282548.2544.22.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 19/22] ima: support for kexec image and initramfs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: linux-security-module@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Date: Fri, 12 Feb 2016 08:09:08 -0500
In-Reply-To: <20160212125333.GC7051@dhcp-128-65.nay.redhat.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1454526390-19792-20-git-send-email-zohar@linux.vnet.ibm.com>
	 <20160212125333.GC7051@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Fri, 2016-02-12 at 20:53 +0800, Dave Young wrote:
> Hi, Mimi
> 
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> > index a5d2592..832e62a 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -147,6 +147,8 @@ enum ima_hooks {
> >  	POST_SETATTR,
> >  	MODULE_CHECK,
> >  	FIRMWARE_CHECK,
> > +	KEXEC_CHECK,
> > +	INITRAMFS_CHECK,
> 
> KEXEC_CHECK is actually kexec kernel image check, INITRAMFS_CHECK is for
> kexec initramfs check, they are both for checking kexec loaded files.
> 
> Do you mind a longer id like KEXEC_KERNEL_CHECK and KEXEC_INITRAMFS_CHECK?

These are the IMA policy tokens.  Currently the IMA policy would include
these KEXEC rules, where "appraise_type=imasig" indicates requiring a
signature as opposed to a hash.

measure func=KEXEC_CHECK
appraise func=KEXEC_CHECK appraise_type=imasig
#
measure func=INITRAMFS_CHECK
appraise func=INITRAMFS_CHECK appraise_type=imasig

I'll change these IMA policy identifiers to the longer names you
suggested.

thanks,

Mimi

> >  	MAX_CHECK
> >  };
> >  
> 
> Thanks
> Dave



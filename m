Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:45284 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbcBJXPL (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 10 Feb 2016 18:15:11 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Thu, 11 Feb 2016 09:15:09 +1000
Message-ID: <1455146051.2538.230.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 17/22] ima: remove firmware and module specific
 cached status info
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
	"Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Date: Wed, 10 Feb 2016 18:14:11 -0500
In-Reply-To: <CACE9dm9dmwfPN_C+kL-ys4TQKDHvyvYuqQKVLbS1=ERju8Z5Lw@mail.gmail.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1454526390-19792-18-git-send-email-zohar@linux.vnet.ibm.com>
	 <CACE9dm9dmwfPN_C+kL-ys4TQKDHvyvYuqQKVLbS1=ERju8Z5Lw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Wed, 2016-02-10 at 22:18 +0200, Dmitry Kasatkin wrote:

> > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> > index cb0d0ff..6b4694a 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -74,13 +74,12 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
> >                 return iint->ima_mmap_status;
> >         case BPRM_CHECK:
> >                 return iint->ima_bprm_status;
> > -       case MODULE_CHECK:
> > -               return iint->ima_module_status;
> > -       case FIRMWARE_CHECK:
> > -               return iint->ima_firmware_status;
> >         case FILE_CHECK:
> > -       default:
> > +       case POST_SETATTR:
> >                 return iint->ima_file_status;
> > +       case MODULE_CHECK ... MAX_CHECK - 1:
> 
> Will LLVM clang handles this range?
> 
> Otherwise it can be just like:
> 
> case MODULE_CHECK ... MAX_CHECK :

Yes, my test program compiled fine with clang.  Similar usage exists in
the kernel (eg. fs/afs/callback.c).

Mimi


Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:32940 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbcAUA1d (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 20 Jan 2016 19:27:33 -0500
Date: Wed, 20 Jan 2016 16:27:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [RFC PATCH v2 06/11] kexec: replace call to copy_file_from_fd()
 with kernel version
Message-ID: <20160121002729.GB26369@dtor-ws>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-7-git-send-email-zohar@linux.vnet.ibm.com>
 <20160120231240.GL11277@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160120231240.GL11277@wotan.suse.de>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jan 21, 2016 at 12:12:40AM +0100, Luis R. Rodriguez wrote:
> On Mon, Jan 18, 2016 at 10:11:21AM -0500, Mimi Zohar wrote:
> > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> > index 4edf47f..3adf937 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -78,6 +78,8 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
> >  		return iint->ima_module_status;
> >  	case FIRMWARE_CHECK:
> >  		return iint->ima_firmware_status;
> > +	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
> > +		return iint->ima_read_status;
> 
> I didn't get the memo that we're OK to use compiler specific extensions
> like this. I'm sure if you are using it its not the first case, just
> want to be sure we are aware of possible issues if some compiler doesn't
> support this.
> 
> If we don't have a precedence can we just avoid its use?

This has sailed:

dtor@dtor-ws:~$ grep -rl 'case.*\.\.\..*:' kernel/work/drivers/ | wc -l
98

Thanks.

-- 
Dmitry

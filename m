Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44596 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343AbcBLMxp (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Fri, 12 Feb 2016 07:53:45 -0500
Date: Fri, 12 Feb 2016 20:53:33 +0800
From: Dave Young <dyoung@redhat.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
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
Subject: Re: [PATCH v3 19/22] ima: support for kexec image and initramfs
Message-ID: <20160212125333.GC7051@dhcp-128-65.nay.redhat.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-20-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454526390-19792-20-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi, Mimi

> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index a5d2592..832e62a 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -147,6 +147,8 @@ enum ima_hooks {
>  	POST_SETATTR,
>  	MODULE_CHECK,
>  	FIRMWARE_CHECK,
> +	KEXEC_CHECK,
> +	INITRAMFS_CHECK,

KEXEC_CHECK is actually kexec kernel image check, INITRAMFS_CHECK is for
kexec initramfs check, they are both for checking kexec loaded files.

Do you mind a longer id like KEXEC_KERNEL_CHECK and KEXEC_INITRAMFS_CHECK?

>  	MAX_CHECK
>  };
>  

Thanks
Dave

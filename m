Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:38738 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbcBKMRv (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 11 Feb 2016 07:17:51 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Thu, 11 Feb 2016 22:17:49 +1000
Message-ID: <1455193012.2538.318.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 19/22] ima: support for kexec image and initramfs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org,
	Rusty Russell <rusty@rustcorp.com.au>,
	David Howells <dhowells@redhat.com>, fsdevel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Date: Thu, 11 Feb 2016 07:16:52 -0500
In-Reply-To: <CACE9dm-VTDNaEJPGamhMY239LQAPCRYp9rvnwbmZijyo7Vh43g@mail.gmail.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1454526390-19792-20-git-send-email-zohar@linux.vnet.ibm.com>
	 <CACE9dm9cqE5cu=0+LujHOGP9XyhGNxYfy52Ds6z+pz+fPwF+pw@mail.gmail.com>
	 <1455146516.2538.237.camel@linux.vnet.ibm.com>
	 <CACE9dm8OJ1cgbKszUG-pCiEMVarUFLLWi_jewVV-JEMGAJsA-g@mail.gmail.com>
	 <1455156500.2538.268.camel@linux.vnet.ibm.com>
	 <CACE9dm-VTDNaEJPGamhMY239LQAPCRYp9rvnwbmZijyo7Vh43g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Thu, 2016-02-11 at 10:47 +0200, Dmitry Kasatkin wrote:
> On Thu, Feb 11, 2016 at 4:08 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> static int idmap[] = {
>          [READING_FIRMWARE] = FIRMWARE_CHECK,
>          [READING_MODULE] = MODULE_CHECK,
>          ...
> };

That works nicely, even with non-sequential ordering or missing entries.
The switch case be replaced with a single line:

func = read_idmap[read_id] == 0 ? FILE_CHECK : read_idmap[read_id]; 

Thank you!

Mimi


Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([125.16.236.3]:42304 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbcBHXeq (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 8 Feb 2016 18:34:46 -0500
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Tue, 9 Feb 2016 05:04:43 +0530
Message-ID: <1454974470.3037.46.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 19/22] ima: support for kexec image and initramfs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petko Manolov <petkan@mip-labs.com>
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
Date: Mon, 08 Feb 2016 18:34:30 -0500
In-Reply-To: <20160207201000.GJ17321@localhost>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1454526390-19792-20-git-send-email-zohar@linux.vnet.ibm.com>
	 <20160207201000.GJ17321@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Sun, 2016-02-07 at 22:10 +0200, Petko Manolov wrote:
> On 16-02-03 14:06:27, Mimi Zohar wrote:
 
> > Option 3: incorportate the ima_hooks enumeration into kernel_read_file_id,
> > perhaps changing the enumeration name.
> > 
> > For now, duplicate the new READING_KEXEC_IMAGE/INITRAMFS in ima_hooks.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> Option 3 seems the right way to go, but for now:

I'm just not sure.  The kernel_read_file_id enumeration is in
<linux/fs.h>.

> Acked-by: Petko Manolov <petkan@mip-labs.com>

Thank you.

Mimi


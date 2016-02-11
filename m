Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([125.16.236.1]:43648 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbcBKTgL (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 11 Feb 2016 14:36:11 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Fri, 12 Feb 2016 01:06:07 +0530
Message-ID: <1455219355.2826.1.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 14/22] security: define kernel_read_file hook
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>
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
Date: Thu, 11 Feb 2016 14:35:55 -0500
In-Reply-To: <56BCBCA9.3040102@schaufler-ca.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1454526390-19792-15-git-send-email-zohar@linux.vnet.ibm.com>
	 <56BCBCA9.3040102@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Thu, 2016-02-11 at 08:54 -0800, Casey Schaufler wrote:
> On 2/3/2016 11:06 AM, Mimi Zohar wrote:
> > The kernel_read_file security hook is called prior to reading the file
> > into memory.
> >
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> 
> Being able to deny the read prior to performing any
> real work makes a lot of sense.

Thanks, Casey!

Mimi


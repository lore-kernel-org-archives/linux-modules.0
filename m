Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:33372 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758145AbcBDXyh (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 4 Feb 2016 18:54:37 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Fri, 5 Feb 2016 09:54:34 +1000
Message-ID: <1454630013.2648.12.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3.1] firmware: clean up filesystem load exit path
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Kees Cook <keescook@chromium.org>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	Josh Boyer <jwboyer@fedoraproject.org>,
	David Howells <dhowells@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org
Date: Thu, 04 Feb 2016 18:53:33 -0500
In-Reply-To: <20160204220122.GL12481@wotan.suse.de>
References: <20160204211501.GA14755@www.outflux.net>
	 <20160204220122.GL12481@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Thu, 2016-02-04 at 23:01 +0100, Luis R. Rodriguez wrote:
> On Thu, Feb 04, 2016 at 01:15:02PM -0800, Kees Cook wrote:
> > This makes the error and success paths more readable while trying to
> > load firmware from the filesystem.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Cc: Josh Boyer <jwboyer@fedoraproject.org>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> > Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> Thanks,
> 
> Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>
> 
> > ---
> > Suggested as an alternative to "[PATCH v3 06/22] firmware: fold successful fw read early"
> 
> Mimi, feel free to pick up as a replacement in your series.

Ok, thanks!

Mimi


Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52628 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753227AbcBDWBY (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 4 Feb 2016 17:01:24 -0500
Date: Thu, 4 Feb 2016 23:01:22 +0100
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Kees Cook <keescook@chromium.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
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
Subject: Re: [PATCH v3.1] firmware: clean up filesystem load exit path
Message-ID: <20160204220122.GL12481@wotan.suse.de>
References: <20160204211501.GA14755@www.outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160204211501.GA14755@www.outflux.net>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Thu, Feb 04, 2016 at 01:15:02PM -0800, Kees Cook wrote:
> This makes the error and success paths more readable while trying to
> load firmware from the filesystem.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: Josh Boyer <jwboyer@fedoraproject.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>

Thanks,

Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

> ---
> Suggested as an alternative to "[PATCH v3 06/22] firmware: fold successful fw read early"

Mimi, feel free to pick up as a replacement in your series.

  Luis

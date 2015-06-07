Return-Path: <andi@rhlx01.hs-esslingen.de>
Date: Sun, 7 Jun 2015 11:25:06 +0200
From: Andreas Mohr <andi@lisas.de>
To: lucas.de.marchi@gmail.com
Cc: linux-modules@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	Andreas Mohr <andi@lisas.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bertrand Jacquin <beber@meleeweb.net>, Marco d'Itri <md@linux.it>,
	lkml <linux-kernel@vger.kernel.org>, Kay Sievers <kay@vrfy.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH kmod 0/3] Add feature list together with version
Message-ID: <20150607092506.GA14394@rhlx01.hs-esslingen.de>
References: <1433658449-3931-1-git-send-email-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433658449-3931-1-git-send-email-lucas.de.marchi@gmail.com>
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Sun, Jun 07, 2015 at 03:27:26AM -0300, lucas.de.marchi@gmail.com wrote:
> From: Lucas De Marchi <lucas.demarchi@intel.com>
> 
> Sample output:
> 
> $ ./tools/kmod --version
> kmod version 20
> +XZ +ZLIB -EXPERIMENTAL

Thank you for this important feature!
(which follows systemd format
as proposed by Kay Sievers)

While we're quite firmly on the non-kernel side here,
I'll still scribble my
Reviewed-by: Andreas Mohr <andim2@users.sf.net>

Andreas Mohr

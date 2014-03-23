Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39006 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749AbaCWVon (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Sun, 23 Mar 2014 17:44:43 -0400
Date: Sun, 23 Mar 2014 18:45:45 -0300
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] Fix a test in the configure script
Message-ID: <20140323214542.GA959@intel.com>
References: <532D8178.1030201@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <532D8178.1030201@acm.org>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi Bart,

On Sat, Mar 22, 2014 at 01:26:32PM +0100, Bart Van Assche wrote:
> Avoid that the configure script prints the following error message:
> ./configure: line 14049: xyes: command not found
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 54a52ea..7ef151e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -112,7 +112,7 @@ AC_ARG_ENABLE([manpages],
>          AS_HELP_STRING([--disable-manpages], [disable manpages @<:@default=enabled@:>@]),
>  	[], enable_manpages=yes)
>  AM_CONDITIONAL([BUILD_MANPAGES], [test "x$enable_manpages" = "xyes"])
> -AS_IF(["x$enable_manpages" != "xno"], ["have_manpages=yes"])
> +AS_IF([test "x$enable_manpages" != "xno"], ["have_manpages=yes"])
>  
>  AC_ARG_ENABLE([logging],
>  	AS_HELP_STRING([--disable-logging], [disable system logging @<:@default=enabled@:>@]),
> -- 

I had another patch applied but not yet pushed:


>From 092d9448e0d46df135db0f6a6c48719e030e6477 Mon Sep 17 00:00:00 2001
From: Lucas De Marchi <lucas.demarchi@intel.com>
Date: Thu, 20 Mar 2014 09:50:12 -0300
Subject: [PATCH] build-sys: Remove bogus line causing warning

./configure: line 14316: xyes: command not found

We are not using have_manpages, so remove it.
---
 configure.ac | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 54a52ea..e95942a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -112,7 +112,6 @@ AC_ARG_ENABLE([manpages],
         AS_HELP_STRING([--disable-manpages], [disable manpages @<:@default=enabled@:>@]),
 	[], enable_manpages=yes)
 AM_CONDITIONAL([BUILD_MANPAGES], [test "x$enable_manpages" = "xyes"])
-AS_IF(["x$enable_manpages" != "xno"], ["have_manpages=yes"])
 
 AC_ARG_ENABLE([logging],
 	AS_HELP_STRING([--disable-logging], [disable system logging @<:@default=enabled@:>@]),
-- 
1.9.0


The difference is that we can completely remove this line since we are
not using it anymore. It was wrongly introduced in 
bccb4b2 ("build-sys: Do not require xsltproc for installation of man pages")



-- 
Lucas De Marchi

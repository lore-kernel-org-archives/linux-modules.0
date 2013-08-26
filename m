Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:41645 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351Ab3HZUnH (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 26 Aug 2013 16:43:07 -0400
Received: by mail-wg0-f54.google.com with SMTP id e11so367026wgh.21
        for <linux-modules@vger.kernel.org>; Mon, 26 Aug 2013 13:43:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1377541250-10193-1-git-send-email-maillist-kmod@barfooze.de>
References: <1377541250-10193-1-git-send-email-maillist-kmod@barfooze.de>
From: Kay Sievers <kay@vrfy.org>
Date: Mon, 26 Aug 2013 22:42:46 +0200
Message-ID: <CAPXgP12fHT79L47dRo3WbSCjBtc6Fkx5DNkH+ovhjojKH5iVSw@mail.gmail.com>
Subject: Re: [PATCH 1/3] remove non-portable usage of strndupa
To: John Spencer <maillist-kmod@barfooze.de>
Cc: linux-modules@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Mon, Aug 26, 2013 at 8:20 PM, John Spencer <maillist-kmod@barfooze.de> wrote:
> usage of strndupa is neither C99 nor POSIX,
> so musl libc does not implement it.
> it's a glibc invention, and a dangerous one since
> usage of alloca() is considered bad practice.

It's as dangerous as variable sized arrays, and surely much less "bad
practice" than your introduced PATH_MAX. :)

If kmod declares posix-only interfaces as the goal, then it's fine,
but your reasons do not make much sense in 2013.

Kay

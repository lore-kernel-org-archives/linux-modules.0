Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DE7C433EF
	for <linux-modules@archiver.kernel.org>; Mon, 17 Jan 2022 05:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiAQFiq (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 17 Jan 2022 00:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiAQFiq (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 17 Jan 2022 00:38:46 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEB0C06161C
        for <linux-modules@vger.kernel.org>; Sun, 16 Jan 2022 21:38:45 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id q25so60807343edb.2
        for <linux-modules@vger.kernel.org>; Sun, 16 Jan 2022 21:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1O8U+wUF4iGrPSEsUvPr9Y9g9nT7ZxuOwHXUzTfTnig=;
        b=gUKhHF9sP7IwLcbDjWCXAhGnqD9tXJYiiBYhhYRsxV841C7QMjWhy6zf3Wx5BW31pw
         gvKGdUglcUAsD+GVsno6Rl+On2LQkVodPB+4EGTYl/M/y+Az2c4g+HlS0OjOLwjGYJ0d
         mena0IQyOaJesacPl8wfwWPX4muMIJkMIRTTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1O8U+wUF4iGrPSEsUvPr9Y9g9nT7ZxuOwHXUzTfTnig=;
        b=A8g6Amm3g2AvuBj7gCj1u8bX8slFYd3EXmwTbbzkQ94MEB5G3dgreO6I3w+JVVTpzs
         qXvW0XBYPy+IiLFsEwaZxiYJoxTkIsR3qtA94smdtqpeHTQAktQGV7FSHUPAEiCtJPNU
         lwY32Al+51I6NVQZUCxHDRsiaGg1/1GAuaJmuYSVir2du7WjcO4tRaAse/YSGCI7lWaM
         xvsdCzBeouyDqfc7wCbglbyNHZPB7m4XYz+imNIfe61o6p0aZGBWMn1yJW9Y/gUVP4NZ
         qaqrvH88iSqNaTc5JsXyWzxeXBEvfYVwhZqAmGBUBdpInBZ/p1yGOr4BOJseXu3KCWcR
         rgEw==
X-Gm-Message-State: AOAM532GZN51KM2C3tP9FV8ZPh/SQ+8H75jPZiAZRsJg7PjbguIoM410
        t4nZbDTTGcY61wyBjkl0WNeORffn6Ae6Qir4
X-Google-Smtp-Source: ABdhPJyew02apiFywcmLIxDrkl/xcehcyW6+jFWOk3zG2jPBjmt8GN+czQ6pgAn9fjmItOBIUaEYnQ==
X-Received: by 2002:a05:6402:c89:: with SMTP id cm9mr18868523edb.304.1642397923596;
        Sun, 16 Jan 2022 21:38:43 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id by26sm2446716edb.31.2022.01.16.21.38.41
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 21:38:42 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id c66so17884343wma.5
        for <linux-modules@vger.kernel.org>; Sun, 16 Jan 2022 21:38:41 -0800 (PST)
X-Received: by 2002:a05:6000:1787:: with SMTP id e7mr3962110wrg.281.1642397921591;
 Sun, 16 Jan 2022 21:38:41 -0800 (PST)
MIME-Version: 1.0
References: <YeITMG7bKozB2xVQ@bombadil.infradead.org>
In-Reply-To: <YeITMG7bKozB2xVQ@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jan 2022 07:38:25 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjCajUWAZBNrQv3zrrjZBH7e7x2UrQ2n18+yk3TpGD9ag@mail.gmail.com>
Message-ID: <CAHk-=wjCajUWAZBNrQv3zrrjZBH7e7x2UrQ2n18+yk3TpGD9ag@mail.gmail.com>
Subject: Re: Modules updates for v5.17-rc1
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Yu Chen <chen.yu@easystack.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sat, Jan 15, 2022 at 2:20 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Although this change was only merged on January 11th, the patches have
> been being reviewed since early december. There was at least one fix
> already found for it and merged.

Grr..

And that's exactly why it matters not about "being reviewed", but when
they were in linux-next etc.

I've pulled this, but consider this a complaint. Things should not be
"reviewed" before the merge window. They should be ready and merged
and have actually seen some testing.

Review is good. But nothing beats actually being out there and
actually seeing real-life testing (of course, linux-next probably
mostly gets build-testing, but what testing it gets is still better
than not being there).

               Linus

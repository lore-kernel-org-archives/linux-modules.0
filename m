Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EF8C05027
	for <linux-modules@archiver.kernel.org>; Fri, 17 Feb 2023 20:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBQUTD (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 17 Feb 2023 15:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBQUTB (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 17 Feb 2023 15:19:01 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0125FC6E
        for <linux-modules@vger.kernel.org>; Fri, 17 Feb 2023 12:18:54 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id x5so2590430plg.9
        for <linux-modules@vger.kernel.org>; Fri, 17 Feb 2023 12:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1nBkXJHOQCjc1Cib5SQzHw5UBXu4/TG9BmbvtOn8x3o=;
        b=CdPU3vWf9z6nfxI9eJh0VGp3/SK3CkuJbz02B2y+OR2cJk9e+ZlsLXOhzYejAPMt9Z
         XPF8YOq4y222hIHAkjx1fN7AwI5D0dyNDVJWYdbehRgCU9T44jpPaf6b3qhEIitPZ1xo
         5OHzy8a56F8EOfsoSqg0QM4jB0c0lJN5V9R7zXc8amDSHCzkMAxVOI+iJkl3k7eOIF58
         S117VKy3W923uDt3dlQOBeMEaeZR+tazRpgvIDWUQKyuqAAOY4t3zK5T3Olka2v258C7
         0Pkd6Y1BeScjtxC77I4gDxXOz70ge4eYOT5jGu9Ix2nskB14V6/hefvD2e1OuXFqGRk9
         yh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nBkXJHOQCjc1Cib5SQzHw5UBXu4/TG9BmbvtOn8x3o=;
        b=uWHf06AfOCpNfRyTdA/d1Pn/o44d3hBei5EdyXcHK+o+kUR4i+0Baj3qEVi2F9yplB
         lvsjiHYsBV/OWRXYtyA0YmDw7fnw9ABSi8aqyW0mRqr2sYqj+UgKQRah2N6U9AcUvT1A
         SryDJHAUhaSNtCzQtobOGFmEHUrM+/+qzVUJBC6pBRJ4ZLDQWlZlcJBHZBrxTIlT6c6w
         lUpF2yovO/FuQkS5IWUKG8AfTPuBM+69wl2gVbTMl3iQ0P4OmwWqluFpE4Lp14DVXrEM
         3nS8VwV2aGhrYnBo2O9NJfKBi/3UzHWFIlL3gr9y9QwbDXR4uODGjCDXXSc9ZoxDwQoi
         aPqw==
X-Gm-Message-State: AO0yUKWjwmDexnpXqo8egLO1n9LRpWcEF094Skz3Zxx8mWj3kFIZ3IbH
        f8qY1gtKqhZFuVZvsEU5jiq9yQ==
X-Google-Smtp-Source: AK7set+Kglt9SWMTcl9U6edBMiVZdRdfyoTwtb7vT0wDVYvYQYr791Dt5GnQA1IjrjIv6xtsYuDn5w==
X-Received: by 2002:a17:90b:1802:b0:233:ab9b:f86a with SMTP id lw2-20020a17090b180200b00233ab9bf86amr2565187pjb.8.1676665133517;
        Fri, 17 Feb 2023 12:18:53 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a0a9000b002348bfd3799sm1956047pjw.39.2023.02.17.12.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 12:18:52 -0800 (PST)
Date:   Fri, 17 Feb 2023 20:18:49 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 06/24] kbuild, binder: remove MODULE_LICENSE in
 non-modules
Message-ID: <Y+/hKbyD6yE8vY1y@google.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
 <20230217141059.392471-7-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230217141059.392471-7-nick.alcock@oracle.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Feb 17, 2023 at 02:10:41PM +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Arve Hjønnevåg" <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Martijn Coenen <maco@android.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> ---
>  drivers/android/binder.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 880224ec6abb..e36164108da6 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -6597,4 +6597,3 @@ device_initcall(binder_init);
>  #define CREATE_TRACE_POINTS
>  #include "binder_trace.h"
>  
> -MODULE_LICENSE("GPL v2");
> -- 
> 2.39.1.268.g9de2f9a303
> 

Acked-by: Carlos Llamas <cmllamas@google.com>

Thanks

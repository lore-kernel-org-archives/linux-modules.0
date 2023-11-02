Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363EF5250
	for <linux-modules@vger.kernel.org>; Thu,  2 Nov 2023 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PZvkTZLS"
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4353112
	for <linux-modules@vger.kernel.org>; Thu,  2 Nov 2023 00:03:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54366784377so866630a12.3
        for <linux-modules@vger.kernel.org>; Thu, 02 Nov 2023 00:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698908590; x=1699513390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V3nhXdUPcKAOv9+XK9xkbhx4vVS0XEkJFjF8wpYBYas=;
        b=PZvkTZLSCjzskNRrUu77F7RNNcqYyUyt7u0oST7Mq66TkkW0RP+vwQ2X3PcwIJPDpR
         MZnHXo23TgwSmDJ/eEx8gssiH70/OrDUC34xXCxn4KZhgRLeyUvopPQeh6UsTbBGjzfe
         MQuTHWVMF6/xGwIoRbPXyJJypr5iwP+hJ3Q3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698908590; x=1699513390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3nhXdUPcKAOv9+XK9xkbhx4vVS0XEkJFjF8wpYBYas=;
        b=fSsI1Wx7pplzxmLQD++lrz9Fn95z9rHYc+RkLzpjdpSDxo79YKeoxIbMyZpWtHWgXc
         cONlee5Zr6revSh+0iixU9Kl09EutW3h9ZMRuvyyIyVUaOB7EkvZyNBHq+VzCrjbEGu/
         onGw9ZNCYZIi0M/JxNGBvOM16aPVN7Aj8mwSzghLff4wQjxoyUfJTrPuHiGP5jjQjs3z
         TI+cJeMhicsdfGuWh3Cjymk9F1mS9vOZXxxMiG/DQV78Nj8BwHfVnhd7J4/1H/lvWmF0
         in3gKM2xQGrkyYPkXS7w1ztD2j7TC2s1fG5YzdrN7KZ2hfCBSWrD8AW34h9lS9Z8NRTu
         ZJtQ==
X-Gm-Message-State: AOJu0YweX8nDqTYGIRlkflX3dusv4nEIW9SBgVSysBgqR9eEdJrG0Bem
	ZOVdhhHp7iun/pio5r47z1H0vSC5ZvPA3nUC7nwpROkS
X-Google-Smtp-Source: AGHT+IHOXb1iKeAbBuByNVYXW7JK0SoskUQX1D+/oEYT4NNr+MGJgMDtsYN4g9AcZtOt6sX5wpAgWQ==
X-Received: by 2002:aa7:c494:0:b0:53d:e5d7:4148 with SMTP id m20-20020aa7c494000000b0053de5d74148mr16293748edq.1.1698908589964;
        Thu, 02 Nov 2023 00:03:09 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id m25-20020a509999000000b00540f4715289sm1960768edb.61.2023.11.02.00.03.08
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 00:03:08 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9d274222b5dso86714566b.3
        for <linux-modules@vger.kernel.org>; Thu, 02 Nov 2023 00:03:08 -0700 (PDT)
X-Received: by 2002:a17:906:4fc8:b0:9bd:ac0f:83dc with SMTP id
 i8-20020a1709064fc800b009bdac0f83dcmr3363405ejw.54.1698908588450; Thu, 02 Nov
 2023 00:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZUKxT1CL9/0Dn6NE@bombadil.infradead.org>
In-Reply-To: <ZUKxT1CL9/0Dn6NE@bombadil.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 Nov 2023 21:02:51 -1000
X-Gmail-Original-Message-ID: <CAHk-=whFXNYXG2ES8HdoaMC=O4bakMXGZezmoqA3SXwn4xJUPQ@mail.gmail.com>
Message-ID: <CAHk-=whFXNYXG2ES8HdoaMC=O4bakMXGZezmoqA3SXwn4xJUPQ@mail.gmail.com>
Subject: Re: [GIT PULL] Modules changes for v6.7-rc1
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, andrea.righi@canonical.com, 
	keescook@chromium.org, zhumao001@208suo.com, yangtiezhu@loongson.cn, 
	ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Nov 2023 at 10:13, Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> The only thing worth highligthing is that gzip moves to use vmalloc() instead of
> kmalloc just as we had a fix for this for zstd on v6.6-rc1.

Actually, that's almost certainly entirely the wrong thing to do.

Unless you *know* that the allocation is large, you shouldn't use
vmalloc(). And since kmalloc() has worked fine, you most definitely
don't know that.

So we have 'kvmalloc()' *exactly* for this reason, which is a "use
kmalloc, unless that is too small, then use vmalloc".

kmalloc() isn't just about "use physically contiguous allocations".
It's also more memory-efficient, and a *lot* faster than vmalloc(),
which has to play VM tricks.

So this "just switch to vmalloc()" is entirely wrong.

              Linus

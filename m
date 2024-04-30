Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8471836C7
	for <linux-modules@vger.kernel.org>; Tue, 30 Apr 2024 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714501636; cv=none; b=IKX0NVseV8wakiw0bnZYQo6VspeS9K/zekRNegIYKjggeJLh2T/qDQXqD7weR9JdAAAidCQc/kHvSgsHnnSC7u/RZvRt2xmcW3eO+GesOb69lMnCkuyIrzG/8OGgGOv+f3auDQB4p2Tj+gFceLPd9ehwu57v4qhjxLZw7b/Fig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714501636; c=relaxed/simple;
	bh=NFF0nICYjNAx74ugEanjnvR+p/5KYPsaF+rjUNon2aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KI98n9Q/183a41AXTb6vUUPh/qVKUMrpAznuE6RZ3esxAg6SfUFNNtILful55iDafnTu7xrjVkK6TOPW5Qx7otwqUqsOuWWT3pM2cnJt4kD+HDiaTUmPv5911q8mGv+dz8rWMyqEhfvsjwW0fb5mt9mFmRV3C9rGijJNjUL+CNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji2S0jRa; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji2S0jRa"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de5b1e6beceso5243369276.0
        for <linux-modules@vger.kernel.org>; Tue, 30 Apr 2024 11:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714501632; x=1715106432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zNRwCSKhiB98e63IXx6I90hA4seb0IM+T9iiGd2ahsg=;
        b=Ji2S0jRaIJB3Kas2K9gMR94CqYdGIEOe/vKRcX4ButGQ48ptVz6jugL7IsQmmEeCqM
         6HNaSA45FMmjHW9w3sMSLMcigI2dV02Q47lQSVrpl67E2iO7wUHs2WS343hLWHZrIvSr
         FKrNSyXtE8WUIO7MwuPdM6ct7TCvGAHKteYUj6bfT3y+uH8svFrE8dic+F/RKnhwHfB/
         tDMTwUMm1LpKIuecsik4vpV2qnE1W8z8mGd7n8MuZvitu2DvLHTCImP/BpQNVlaUj8mT
         eYvl83Og33L2o1XqUEt3QijJyXc5D9pQNLc6LF8/HOJHKeKZq9fgOiWpfwownNTfQe4a
         8Zag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714501632; x=1715106432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zNRwCSKhiB98e63IXx6I90hA4seb0IM+T9iiGd2ahsg=;
        b=BMOzCEkPNcQAjuRFvS5nuRB+JAyRhgTHHSb+J0j2BJvP4S+c82rHhDkgaRFzKFM6VX
         QhnXjtGAliIzo1uKZtEJvL0w1FZaSzxaMG/w7+uEXVVmLB7MTnJ19PJy+6NzaGHkVvBF
         BjtVZFaaNEXntZBDCo0RGC+O9wV7ZOLDN5+OHiXuMAhNUFbm6VYqYNXz4hr7jtgSe7xw
         iVtfsw7AGYoM43qZ/9leGs1OZARlG0JtXs6O77m/93INU9tI+pphH8eWCjD4rxLdBti8
         9Nv42EhNkC7SoxHY21mj6elKTMvvmSsJeYUSpE7cBRHu/xqbhiGAIfq2GEc0damOLyQz
         3PJQ==
X-Gm-Message-State: AOJu0YxlMJYEUJW/ufOcMcX60QIN66Lgw6wR6OLI06A4HqyjOUWhyvMy
	4milEbn5sCUVr5RahN6Be55+yB2i8MHvzrsFoUEXaYP1ALqzmRe33i5AXSY8/+No28TIGPHpYWD
	LNLVeUYnL6BuZTQRkVX45lOOQ7x4aUA==
X-Google-Smtp-Source: AGHT+IE00fuxY8kbmUGkrBZaSUhINtzOiOTzjCqxf+KxRZH4D2safMvNUhiJ2q6d+MnhZtieGiwYx24RACCK96lWqcM=
X-Received: by 2002:a05:6902:248e:b0:dcc:1c6c:430d with SMTP id
 ds14-20020a056902248e00b00dcc1c6c430dmr480900ybb.12.1714501632313; Tue, 30
 Apr 2024 11:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-9-06f92ad07985@gmail.com>
 <37jvg2krroliuncyposassjhznjcgrxmvdre4mesl23npukbpn@jz7ntjkcpd7o>
 <CACvgo52PTWuDcv-P0Ls1oESo-cOsygUpD-rbK9oUTHy30HpS6w@mail.gmail.com> <evfd7gytzrrtmvj5tjuxpwy5k463xeoe5rc2y5nrisgv7soqpg@veupfudya45x>
In-Reply-To: <evfd7gytzrrtmvj5tjuxpwy5k463xeoe5rc2y5nrisgv7soqpg@veupfudya45x>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 30 Apr 2024 19:27:00 +0100
Message-ID: <CACvgo50mEAQkDSJxqF2=QKNGbnBZ7QbdKZDgy9adDy68rLbP5g@mail.gmail.com>
Subject: Re: [PATCH kmod 09/13] libkmod: swap alloca usage for a few assert_cc
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 19:18, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> On Tue, Apr 30, 2024 at 06:54:00PM GMT, Emil Velikov wrote:
> >On Tue, 30 Apr 2024 at 18:39, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> >>
> >> On Mon, Feb 12, 2024 at 05:23:10PM GMT, Emil Velikov via B4 Relay wrote:
> >> >From: Emil Velikov <emil.l.velikov@gmail.com>
> >> >
> >> >Since all the compression magic is always available now, we don't need
> >> >to loop at runtime nor use alloca - latter of which comes with a handful
> >> >of caveats.
> >> >
> >> >Simply throw in a few assert_cc(), which will trigger at build-time.
> >> >
> >> >Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> >> >---
> >> > libkmod/libkmod-file.c | 22 ++++++++--------------
> >> > 1 file changed, 8 insertions(+), 14 deletions(-)
> >> >
> >> >diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
> >> >index b69f1ef..5b88d6c 100644
> >> >--- a/libkmod/libkmod-file.c
> >> >+++ b/libkmod/libkmod-file.c
> >> >@@ -410,7 +410,6 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
> >> > {
> >> >       struct kmod_file *file = calloc(1, sizeof(struct kmod_file));
> >> >       const struct comp_type *itr;
> >> >-      size_t magic_size_max = 0;
> >> >       int err = 0;
> >> >
> >> >       if (file == NULL)
> >> >@@ -422,22 +421,17 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
> >> >               goto error;
> >> >       }
> >> >
> >> >-      for (itr = comp_types; itr->load != NULL; itr++) {
> >> >-              if (magic_size_max < itr->magic_size)
> >> >-                      magic_size_max = itr->magic_size;
> >> >-      }
> >> >-
> >> >-      if (magic_size_max > 0) {
> >> >-              char *buf = alloca(magic_size_max + 1);
> >> >+      {
> >> >+              char buf[7];
> >> >               ssize_t sz;
> >> >
> >> >-              if (buf == NULL) {
> >> >-                      err = -errno;
> >> >-                      goto error;
> >> >-              }
> >> >-              sz = read_str_safe(file->fd, buf, magic_size_max + 1);
> >> >+              assert_cc(sizeof(magic_zstd) < sizeof(buf));
> >> >+              assert_cc(sizeof(magic_xz) < sizeof(buf));
> >> >+              assert_cc(sizeof(magic_zlib) < sizeof(buf));
> >>
> >> ../libkmod/libkmod-file.c: In function 'kmod_file_open':
> >> ../shared/macro.h:25:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
> >
> >Is there a particular use-case for explicitly forcing C90?
>
> not forcing C90, but forcing -Wdeclaration-after-statement as per
> flag passed in configure.ac. I think the message given by gcc is
> misleading here.
>

Indeed thanks. Seems like I should add `export CFLAGS+=-Werror" to my dev box.

-Emil

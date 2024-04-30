Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26827175560
	for <linux-modules@vger.kernel.org>; Tue, 30 Apr 2024 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499654; cv=none; b=rHngIY1BbCKgv7+kG62Pgj8JD0P6/+jPNpeVrYaNOG0QTvUd1QUKyrTcjYEszk4JMfJh9ktCCLBVhmeaYsItidPnOxXIH8m9bXMEW+5xsLbPlr3Wg/OXgdNVYNENg82DfV8t3kU/BJ6FKK/aM89RDysXDANCKnJXZ3guURc195A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499654; c=relaxed/simple;
	bh=MlSdliP1pgdfDIH28DYZxTce6C6az7GwMk8voPKIq8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJsAQgruDIfxJyqdNHF5BcRRrSfnoVV2iXBQIuPz0bVIf07CKJP9n2wqKOSL22Yb7ljxtlgANLN5mKuttbjKxBgs9JR1MuRWtBcRw203KwqGdfSrq47L8lCxPsx1Q/cGfIVBL4hX63of245zPT/7+UVTuUJIO8ZkzxtwCyVH7TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4rlG/l3; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4rlG/l3"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de5acdb3838so5083365276.1
        for <linux-modules@vger.kernel.org>; Tue, 30 Apr 2024 10:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714499652; x=1715104452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NPCurX9Q7QqRkpV8DlvYMt2ev0L44U682Oe1yVJJJAg=;
        b=J4rlG/l33HhIAaTPNO/V70i7sGiAP07Iu14ZtKdgw7iZqTpSuan0NpJkradsZYnjPv
         Q8SP3MJk0CSzje5okdkCeQfjF39DqPmT+sFaZZQee6JL9qddKY0ElISSKPogdmXZ8OhP
         +Gg8TzOcWDluDYKHXaljnjmi5smKA6LDmZGzMz1+OmTdsg7/0EA5jrpC0IXN8+DXb4lx
         veftOJRcZ7JQVhF63TnnOIjzWy2D33Gx1X458Q9NtsxxjGMoAmgKwSruEhuYPwLg9Jfj
         O46R0aTCXYGk7aLBXnGIJcllu2PTQdPUC4c50Ngyb3zppN1qu/1bm8jOxsWsUy8nzwi7
         r1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714499652; x=1715104452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPCurX9Q7QqRkpV8DlvYMt2ev0L44U682Oe1yVJJJAg=;
        b=QYjqQeR3ZuUlKlFYuVJez/1hnFTX9NTV0RXWlM/Vi9z/r9GEe6hVFcHlvXztp2yG2k
         3KKpUppyMk8q+kd60iZpWYbGq/OhYi+Xp3V0WNV3xyOh4GLjkTvT9BhRWn6EFAfMjnnD
         Xut3EFDNVLpU895Yfmf1tuqu9dcqU2RaDhEwjyRDvCXxYNdnzsODK3HNdPnXuq46Xv1r
         HBJBNpTPe5pSQ08jOOwXD0pfsU+KMgVpOgZaZQXMZrSulmA4NJJaPvc9Vj4EorxK+bKQ
         NsHp2X+Emyg9taic8189FMBxjn5Os5gAXaFUSHkNtWsxyd5L+j4kynk4IubIAkxKasUI
         AkdA==
X-Gm-Message-State: AOJu0YxnZlkP56/2rQKMN4wTIVxvX2u+4Ybu2UJ2qapiKW2sIrHqzp+6
	wEPabFMVy7nTuBdyYiuneJBpAsBlLx9CKpMbpElzS8yYyIwer6xtTmORu7Hb+7R4Qx4nBqBaT3y
	aoLCpK00nVzQ323zUV1og+5pkRhY=
X-Google-Smtp-Source: AGHT+IFlgTlhVcnjUKG+X7YIMtkTM+wYz6GBLD9WI5c27zOzCLg6Yq1615wAtvO2Na6dG/tJGUPPsDuwOAmXa5VJbm4=
X-Received: by 2002:a25:ce8c:0:b0:dcb:e82c:f7f with SMTP id
 x134-20020a25ce8c000000b00dcbe82c0f7fmr273561ybe.12.1714499651982; Tue, 30
 Apr 2024 10:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-9-06f92ad07985@gmail.com> <37jvg2krroliuncyposassjhznjcgrxmvdre4mesl23npukbpn@jz7ntjkcpd7o>
In-Reply-To: <37jvg2krroliuncyposassjhznjcgrxmvdre4mesl23npukbpn@jz7ntjkcpd7o>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 30 Apr 2024 18:54:00 +0100
Message-ID: <CACvgo52PTWuDcv-P0Ls1oESo-cOsygUpD-rbK9oUTHy30HpS6w@mail.gmail.com>
Subject: Re: [PATCH kmod 09/13] libkmod: swap alloca usage for a few assert_cc
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 18:39, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> On Mon, Feb 12, 2024 at 05:23:10PM GMT, Emil Velikov via B4 Relay wrote:
> >From: Emil Velikov <emil.l.velikov@gmail.com>
> >
> >Since all the compression magic is always available now, we don't need
> >to loop at runtime nor use alloca - latter of which comes with a handful
> >of caveats.
> >
> >Simply throw in a few assert_cc(), which will trigger at build-time.
> >
> >Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> >---
> > libkmod/libkmod-file.c | 22 ++++++++--------------
> > 1 file changed, 8 insertions(+), 14 deletions(-)
> >
> >diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
> >index b69f1ef..5b88d6c 100644
> >--- a/libkmod/libkmod-file.c
> >+++ b/libkmod/libkmod-file.c
> >@@ -410,7 +410,6 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
> > {
> >       struct kmod_file *file = calloc(1, sizeof(struct kmod_file));
> >       const struct comp_type *itr;
> >-      size_t magic_size_max = 0;
> >       int err = 0;
> >
> >       if (file == NULL)
> >@@ -422,22 +421,17 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
> >               goto error;
> >       }
> >
> >-      for (itr = comp_types; itr->load != NULL; itr++) {
> >-              if (magic_size_max < itr->magic_size)
> >-                      magic_size_max = itr->magic_size;
> >-      }
> >-
> >-      if (magic_size_max > 0) {
> >-              char *buf = alloca(magic_size_max + 1);
> >+      {
> >+              char buf[7];
> >               ssize_t sz;
> >
> >-              if (buf == NULL) {
> >-                      err = -errno;
> >-                      goto error;
> >-              }
> >-              sz = read_str_safe(file->fd, buf, magic_size_max + 1);
> >+              assert_cc(sizeof(magic_zstd) < sizeof(buf));
> >+              assert_cc(sizeof(magic_xz) < sizeof(buf));
> >+              assert_cc(sizeof(magic_zlib) < sizeof(buf));
>
> ../libkmod/libkmod-file.c: In function 'kmod_file_open':
> ../shared/macro.h:25:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]

Is there a particular use-case for explicitly forcing C90?

The configure.ac contains `AC_PROG_CC_C99`, which seems reasonable
IMHO. Plus the autogen.sh goes a step further with `-std=gnu11`

Thanks
Emil

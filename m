Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F16C172BD7
	for <linux-modules@vger.kernel.org>; Tue, 30 Apr 2024 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502880; cv=none; b=hg+LVdsraG4Uy0I3k72zN374hLikj0gH/1cjEIeK5tY2vDmGpr7KqPRBIhgr/c96IcD/1UH5ClQdH9GSzA5OhGui6hrMyvMzPia9iToVYEfL4DvlKee92k5/LYOwiLfCJrSMXGnRFAycygQmyQPAZPZ/2fiid7o1XdBE/56cw2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502880; c=relaxed/simple;
	bh=s7h0xuGZlBX5jMiPiDfkIBLQmt3uoITJwwnwehTNvtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlqEP93ZT6bL6/Is3FNCILRDtJ8QCZvCXroKCSKJn/3sEn6AnnLSugsgryIyFqAIyIQCcOWoM3oJkajN8hiUKmB3JlN0kPuZ4rp6khhulPMscWHVgOEB9At1zoQpV1gm7u1JpER0y14lMBDtysmciORwHX+4M+UG1/GfmnpS0NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cm9QJAdH; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cm9QJAdH"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de607ab52f4so1973550276.2
        for <linux-modules@vger.kernel.org>; Tue, 30 Apr 2024 11:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714502878; x=1715107678; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j6ONc1CTGu1gXfpv/fU94jf7+hNKx0AcIZeNK5+pVV0=;
        b=cm9QJAdHXbi3RX/LqtQ7EvbMBwInsCpriP1JakKoCCupCnEGC1D7WcdZyujhstdPrw
         HS3sPbJY5oxH/PhoMysMMrQcM2hlDCyYEoDmu/FHIhUII9fv4QQYq+Igj35hP7QS3kJt
         lbs6MJJ++WbZd+7rlHwJKk7ehUv0hXZJ7lf2wgcqweygVIhaImqovuuKy7ImmutxRihp
         xNFEIyXs8k/0dPgFuG+zmdwE+5REysorRFMuDtgfcgBOkoAk2as+/4fvWz9r26t9yHrX
         HbkqUBTf0xKXRVFyyWlg02mEiQAZLawhwF+YXZSAazXMF9NLyAuXz3Fdvsi+QTSq78Nn
         +S8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714502878; x=1715107678;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6ONc1CTGu1gXfpv/fU94jf7+hNKx0AcIZeNK5+pVV0=;
        b=JgS3SiQgK+6lAfQXbFLlf75bsCIDsiYtuSjMEAkIK5FEPG51POy1WXzU/nm5JWzTww
         JjI7ovvn7WPMFQMSsm9iuPD8wi6noyZ+/1m810kp5T1jLeTWTvVhqmkdkL3Xu/3EpZHf
         w95P4YDETFHV/0uGLmxrjvuSS9v3LBFP20XvyOTaIakxpq9bzAoFezaurZ5iBlbRHUhJ
         3HT1MJPY/M3uzaNBPeeiaIYr/B6wuAIIjGTt2GYg9SU8vKEzsvrG0hM0Yj5NQD7uJb86
         YVq+5z/IrpKS00m8B4MmP0WVJjAH3Fwd0yl1PjZabEnBXUx9DijSs0XI9DB8ui9iSHK+
         lgcA==
X-Gm-Message-State: AOJu0YzQsf94ANly/9Xj97/BrImVd99sZRRadzUuYxNKI6A4Tcb+KnFh
	ILVaQmkPrtJvVGpkniyV/IroOyL1HtqE3UrGR7Y6JiSNMzrWyDjKo3iIxxoajAK/LywWL+QUhC9
	Ss1Ri3Zsc8nJsKxvNaGnKfar9oxw=
X-Google-Smtp-Source: AGHT+IGDl4jvKdlo12knCisqll2oBaDekgBqsnBjcENQ8wbS5+XycLjK23LuCjDdoTQTWhdqnfOtpPk4alNJoYqEbGY=
X-Received: by 2002:a5b:50b:0:b0:de5:4b29:b733 with SMTP id
 o11-20020a5b050b000000b00de54b29b733mr474360ybp.24.1714502877988; Tue, 30 Apr
 2024 11:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-9-06f92ad07985@gmail.com>
 <37jvg2krroliuncyposassjhznjcgrxmvdre4mesl23npukbpn@jz7ntjkcpd7o>
 <CACvgo52PTWuDcv-P0Ls1oESo-cOsygUpD-rbK9oUTHy30HpS6w@mail.gmail.com>
 <evfd7gytzrrtmvj5tjuxpwy5k463xeoe5rc2y5nrisgv7soqpg@veupfudya45x>
 <CACvgo50mEAQkDSJxqF2=QKNGbnBZ7QbdKZDgy9adDy68rLbP5g@mail.gmail.com> <fy4a43i62oo42sukpmodrejhglibxbkzom3sgdow4rxsg6j3cj@6l3h466hxsjs>
In-Reply-To: <fy4a43i62oo42sukpmodrejhglibxbkzom3sgdow4rxsg6j3cj@6l3h466hxsjs>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 30 Apr 2024 19:47:46 +0100
Message-ID: <CACvgo53TX3EnUA-NJPuBRZKO3mLM3u_KJdBWjnV4kENVagVxMg@mail.gmail.com>
Subject: Re: [PATCH kmod 09/13] libkmod: swap alloca usage for a few assert_cc
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 19:43, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> On Tue, Apr 30, 2024 at 07:27:00PM GMT, Emil Velikov wrote:
> >On Tue, 30 Apr 2024 at 19:18, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> >>
> >> On Tue, Apr 30, 2024 at 06:54:00PM GMT, Emil Velikov wrote:
> >> >On Tue, 30 Apr 2024 at 18:39, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> >> >>
> >> >> On Mon, Feb 12, 2024 at 05:23:10PM GMT, Emil Velikov via B4 Relay wrote:
> >> >> >From: Emil Velikov <emil.l.velikov@gmail.com>
> >> >> >
> >> >> >Since all the compression magic is always available now, we don't need
> >> >> >to loop at runtime nor use alloca - latter of which comes with a handful
> >> >> >of caveats.
> >> >> >
> >> >> >Simply throw in a few assert_cc(), which will trigger at build-time.
> >> >> >
> >> >> >Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> >> >> >---
> >> >> > libkmod/libkmod-file.c | 22 ++++++++--------------
> >> >> > 1 file changed, 8 insertions(+), 14 deletions(-)
> >> >> >
> >> >> >diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
> >> >> >index b69f1ef..5b88d6c 100644
> >> >> >--- a/libkmod/libkmod-file.c
> >> >> >+++ b/libkmod/libkmod-file.c
> >> >> >@@ -410,7 +410,6 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
> >> >> > {
> >> >> >       struct kmod_file *file = calloc(1, sizeof(struct kmod_file));
> >> >> >       const struct comp_type *itr;
> >> >> >-      size_t magic_size_max = 0;
> >> >> >       int err = 0;
> >> >> >
> >> >> >       if (file == NULL)
> >> >> >@@ -422,22 +421,17 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
> >> >> >               goto error;
> >> >> >       }
> >> >> >
> >> >> >-      for (itr = comp_types; itr->load != NULL; itr++) {
> >> >> >-              if (magic_size_max < itr->magic_size)
> >> >> >-                      magic_size_max = itr->magic_size;
> >> >> >-      }
> >> >> >-
> >> >> >-      if (magic_size_max > 0) {
> >> >> >-              char *buf = alloca(magic_size_max + 1);
> >> >> >+      {
> >> >> >+              char buf[7];
> >> >> >               ssize_t sz;
> >> >> >
> >> >> >-              if (buf == NULL) {
> >> >> >-                      err = -errno;
> >> >> >-                      goto error;
> >> >> >-              }
> >> >> >-              sz = read_str_safe(file->fd, buf, magic_size_max + 1);
> >> >> >+              assert_cc(sizeof(magic_zstd) < sizeof(buf));
> >> >> >+              assert_cc(sizeof(magic_xz) < sizeof(buf));
> >> >> >+              assert_cc(sizeof(magic_zlib) < sizeof(buf));
> >> >>
> >> >> ../libkmod/libkmod-file.c: In function 'kmod_file_open':
> >> >> ../shared/macro.h:25:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
> >> >
> >> >Is there a particular use-case for explicitly forcing C90?
> >>
> >> not forcing C90, but forcing -Wdeclaration-after-statement as per
> >> flag passed in configure.ac. I think the message given by gcc is
> >> misleading here.
> >>
> >
> >Indeed thanks. Seems like I should add `export CFLAGS+=-Werror" to my dev box.
>
> so, are you ok that I just squash this?
>

Yes, of course.

-Emil

Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A914278E7B
	for <linux-modules@vger.kernel.org>; Fri, 22 Aug 2025 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891450; cv=none; b=qvi2rvfFah5c5utO6z+PTY3ODJbDG37AXnBWUnweNf1zTjtWM18wHBARNVEeZStbKJoGCatgpwF5Ho0w65zas9wnYLw1+2E0KiryfJAn/MKMZZBGd6jonrnsQH18SmVaOaDEbif7QHLXc9iMal2sOIT0M1Sjc3wyFkN/do4qgNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891450; c=relaxed/simple;
	bh=Tp/e7RnCZ5utCSTvwI/+YYqeFiNEXOdt3Qq8aW1TM0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLPiLr135YaLSnqry20oQrvB/1ZAHSRIWOjwCSzL7d9BZeD2XiV9937h3EmbPoW6TaE/WYtv7SBaQhYi0QuHeuoqe4evYqyG0tLD7xKQJpzroBGbd7jVRCAN2Pb67AG0OG7EIuokQd1hFzEM5sMjjK8p5thGcyn42UzkGa7M0a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JsrJbd7G; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JsrJbd7G"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-459fc675d11so875e9.1
        for <linux-modules@vger.kernel.org>; Fri, 22 Aug 2025 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755891447; x=1756496247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tp/e7RnCZ5utCSTvwI/+YYqeFiNEXOdt3Qq8aW1TM0Q=;
        b=JsrJbd7GMSI15hbh7K884l9RzS8sZt41j13uIrRU7Q1EIgyWLg6DhsvxemZmHX4ZN0
         HIBwqiiuYwfk5Lk6bQRVwJuCJC7Kx6bFXNjvdm/s61SGKqtgfL+iHa6CP3fT/NZ57QMH
         mtleSnZ73iTq/zKB1MGt72mk3yRjTzWe/6bZLK1D463av60mS3EweJa9KnYyqownWm7s
         Ph+/+BandfWbl0XdgeV3nnUYsTq7L0oIgo8KkahR3uFeL49kBlLgWq0FEXSrMu2cjXtg
         l2HBsZGqrflZ89BDBBN1KQxI+t13kuxrTy8AeROZKJecs3qgyBizEGDm5abrrwED9sOs
         Fg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755891447; x=1756496247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tp/e7RnCZ5utCSTvwI/+YYqeFiNEXOdt3Qq8aW1TM0Q=;
        b=wUVU2Q3w4+MiRsDSDhAbujVPNfxhydI3mWYFwoEwrDkZ2DCRA8/Xr+BSr5Ct7J7mS7
         kHAt0NuIyk/MnUzf3uN4msu07DDJsUX2SeC0q4G/OtRTD4UOCca/TlmogPweezSfBzN5
         3TgfojxtecXgl3gCfn5rh/fH1D9sGYEv4i8XIngNDR8mvf37+kcwVhz1u1ehWRBq4Q3j
         Zc38hh2NXKky9wNA8ciqjd85SFJ/nm3rBh0Uo0dBvwpD7g1qTxAqz+a3HSP25OG6N3TC
         JPjYnc2vy53hu+PsqWs6DcH7jFHWIixl8Zhu0Sh5NCsvdZwVU6KNz4HOtH1/GOcSccwo
         SMKw==
X-Forwarded-Encrypted: i=1; AJvYcCUHQSmKywMMwC85gFDmGKiNJQzFvn2N23EB1ZmqA2AY+ttHIQ5JOQ1LxOl4PapWOj0jUUHUnxzrbhIOJy0W@vger.kernel.org
X-Gm-Message-State: AOJu0YxiKnK4IUEGNUfP8R4WHFWuIECAer5r9uln+gihoS3A0WfvdHlj
	Hu2eiL1/G81wZ64bIx+pGQ/e/iAxm5t/0zRkygiqbF5HybIwK1b1zpZhToxxauV3bkLc5VonBtD
	U698aeLSlGCz5+/wp8G5/M6KT4fokdfBaOsk9cYXF
X-Gm-Gg: ASbGncsvc+8kvN0OABYly1FiKzHeDZQS00PIsTXdci0+FkxMDJLDZnWr4kSvHxSUM9L
	xldJ7ECsZ9GgXUdIM4PvjPNzwJd0w7TPsAlO6dfUdlDr1o+VKVve0GJD+UFneJmoLepf2TswAwa
	ehCV8l1V/cEat0uLkLn2PaOTrR9OmJk9aQNseT/s6dnqhN3ceLKz1IeNUPPf8d0H7XCUh05Bayo
	yAL5mmkDKU=
X-Google-Smtp-Source: AGHT+IFM8Qc04SB7n51+lw9eWU3mlfK5MlxysgYm2SUd8YtzaBNBwqQKXqGL1U0gTHjo7ngSKm60iexhv+vmlEaWOuU=
X-Received: by 2002:a05:600c:609a:b0:458:92d5:3070 with SMTP id
 5b1f17b1804b1-45b57d7950fmr162795e9.6.1755891447281; Fri, 22 Aug 2025
 12:37:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822125454.1287066-1-wangjinchao600@gmail.com> <20250822125454.1287066-2-wangjinchao600@gmail.com>
In-Reply-To: <20250822125454.1287066-2-wangjinchao600@gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 22 Aug 2025 12:36:47 -0700
X-Gm-Features: Ac12FXw3JD5OhMNY1bdXpTG2iWnDIEoV5tjk548--5EgawhWSc6BYxskVA_msPM
Message-ID: <CABCJKucGtbZw_DCpnbUr7cQeU+_DF97YTeDVgPX7tTyPwNabog@mail.gmail.com>
Subject: Re: [PATCH 1/5] module: Fix module_sig_check() for modules with
 ignored modversions/vermagic
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 5:55=E2=80=AFAM Jinchao Wang <wangjinchao600@gmail.=
com> wrote:
>
> The current signature check logic incorrectly fails modules that have
> valid signatures when the caller specifies MODULE_INIT_IGNORE_MODVERSIONS
> or MODULE_INIT_IGNORE_VERMAGIC flags. This happens because the code
> treats these flags as indicating a "mangled module" and skips signature
> verification entirely.
>
> The key insight is that the intent of the caller (to ignore modversions
> or vermagic) should not affect signature verification. A module with
> a valid signature should be verified regardless of whether the caller
> wants to ignore versioning information.

Why would you need to ignore versions when loading signed modules?
Here's the original series that added this check and I feel it's very
much relevant still:

https://lore.kernel.org/lkml/20160423184421.GL3348@decadent.org.uk/

Sami

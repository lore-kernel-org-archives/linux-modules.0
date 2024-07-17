Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48067470
	for <linux-modules@vger.kernel.org>; Wed, 17 Jul 2024 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236553; cv=none; b=JNS2q27Po6eeNK/EGQ5Y1TtNHwmNDpTiQe30wMunDV939tvbph6QCVr9eYMHG3px/5GaXqI5vjYpg4nkzIzUESXKuWhmLIklK2utrf2qPRg9TRMuZoixxuxm8DBzoRojzDnRXW8yoyLht+vPx2FQVmXl5tBJMjgWnfVuYRPsE+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236553; c=relaxed/simple;
	bh=/XMQaXe/J1QkSt85MCV5HDVSD37MM07FaZdQ3hQw9HU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFnZ+95o/IPWbs8Dwa3MU6nfDEmCGu6Hdv6G9nYoxjdBFj3/d7OkRY4SRGeK8LbCREjLxslEDA9RALo37wEjxKNdbsIF8v/CQyX15I6httdV4Y5a9UQBDF5x4Deo2/gUTB/CVgwzt1CfAYid6T+hwbSfXSjA5PuKywkjvsdWihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zo9no+YC; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo9no+YC"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso212111fa.1
        for <linux-modules@vger.kernel.org>; Wed, 17 Jul 2024 10:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721236550; x=1721841350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3MlB8rZkpFZkf3lygBuKfuqdW+WTfjZhmMZdMIpd0bQ=;
        b=Zo9no+YCjkgTRPam2/C6TyFC/kg9Z63hTjFPLyjA2QP3Vw0vSAh/nssiSMUQEXt6+v
         RPhoPd7ovi87uxv8Q9poVz6gSWI8wx3rFYLhtNTT7cnkweRe4JPhH7w8CZh6SPb9xMQq
         79/Zjzv3igHf0ril2mxWNv/fIXZ22wnjezZiUvjcPN0ZRNv8sX1cT07znQSHkHdFNf8J
         XBUzh5sB0S1ib2XbZBVPZsbOpi/EAsTa6B0MplJH/ljvelp5oWsIf8iP6EgGlJzoSN3H
         ARCqM+RTlCTx5IS7ecNwcvrNiBUtwcQdSZ4R5gLgm6wFO1x1zUVInDfU4wboiZRGVB1O
         VDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721236550; x=1721841350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MlB8rZkpFZkf3lygBuKfuqdW+WTfjZhmMZdMIpd0bQ=;
        b=u93vZ2EbR75v4AYMd/F4o6XXfHXkIdR53bc9Q6lpm7xuQdagc8hiuZV2SEYnUp3y3k
         qpKHa9uRVfQ8fKknAkER9fY6i5jl8GLi8k1r90ysCkglXv4lQpIo8q34niIKrb6Sydly
         3BDNwKExuDB03MHG8Uyzr+D6K2NYbcQ51U3jQ2dUCwss0mcH6It5lsdn5lXWuixWGNRr
         W/E75tds5NXXOgVYIG9Vq6AMIUktyDRKrrICXybsw4y9sNbPsTdESbLiaPEQAgGT0mse
         acjYPZK/VL3bhX4IRmvRGF6sNEfR9+p57BPz4/Fg+V00PRG76IrwzcPe/l61yEUxEr6P
         tdvQ==
X-Gm-Message-State: AOJu0YzosYHUcHevwfpNK9Qa7ScRhJPh4KevSYCb8PglJZWR+/ekH788
	mEXhYUfETTww3uM2sbxeDe1p9hd1HS0HowZVDCTDHYCOwTqTRUKRjN+UdT5R6Wj0mEgAr/To8BF
	hf1Sgj/I0G3rvgrpucYg4P1UX62V79w==
X-Google-Smtp-Source: AGHT+IHN2fXhxeqYYXlKbDz8LMpesMJ7IU9I7/qNOSzD4QWJYmE1KLHq0jaj8FXv1oi/hwlT3V3RCpNvwoofjwLM9ZQ=
X-Received: by 2002:a2e:888a:0:b0:2ec:18e5:e686 with SMTP id
 38308e7fff4ca-2ef05d4384emr317601fa.33.1721236549702; Wed, 17 Jul 2024
 10:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712132449.780421-1-lucas.de.marchi@gmail.com>
In-Reply-To: <20240712132449.780421-1-lucas.de.marchi@gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 17 Jul 2024 18:15:38 +0100
Message-ID: <CACvgo535EbKyjyPvBfYiuOeGGUYr38Ac=zT3dd-Mx_QWc0tkAA@mail.gmail.com>
Subject: Re: [PATCH] README: update to a decade+ later
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 14:25, Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:
>
> - State support for clang and other libc's
> - Fix typos
> - Reword the compatibility with module-init-tools section,
>   removing most of the specific examples as we didn't keep
>   track of all of them, and they are not important anymore
>   in year 2024
>
> Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
> ---
>  README.md | 65 +++++++------------------------------------------------
>  1 file changed, 8 insertions(+), 57 deletions(-)
>
> diff --git a/README.md b/README.md
> index 9b22bd7..1aa023d 100644
> --- a/README.md
> +++ b/README.md
> @@ -44,9 +44,9 @@ module-init-tools project.
>  Compilation and installation
>  ============================
>
> -In order to compiler the source code you need following software packages:
> -       - GCC compiler
> -       - GNU C library
> +In order to compile the source code you need following software packages:

s/need following/need the following/ perhaps?

Although feel free to land it as-is. There are a few nitpicks/markdown
fixes that I will send as follow-up.

In either case:
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

> +       - GCC/CLANG compiler
> +       - GNU C library / musl / uClibc
>

Will add a patch for clang permutation, as your CI series lands.

-Emil

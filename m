Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768355FDD6
	for <linux-modules@vger.kernel.org>; Tue, 13 Feb 2024 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842035; cv=none; b=INrdYcfeAED5zjIqapz8JsX8w8KHV0GjHdxChUJIlzWBIU+B1kiK/5ZiL6awJU/ukUMZPrJBmXeEWDAT6aeNcoCT1/zxNEvOokmsIM1d8RAO8kdy2S6+ThRPn5+1jG22/1tR3GkKIDUAVUrBFhQ0c9ulPq4VxL7x9FfakTEbf+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842035; c=relaxed/simple;
	bh=SlWc9xQMfTrwQXe+wBhBQiNH1Ihf751q05cKxK+WaTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPFh8VC3VZxeN66/OkCeqkYECYNzju6coyyM6VusENMHzQzsRvLRj+GmASjfIZKxLc2PB468MQ7GcK/N+b7XG+rwR1UY5S88392Xrxvfc34TK9pnG7nZ7oqUge3HDw48o3L23iKsAmkV03dxZPHGC/9rDDqdQtWlhzyQdydolJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgqA8Idl; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgqA8Idl"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso733231276.1
        for <linux-modules@vger.kernel.org>; Tue, 13 Feb 2024 08:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707842033; x=1708446833; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SlWc9xQMfTrwQXe+wBhBQiNH1Ihf751q05cKxK+WaTU=;
        b=cgqA8IdlZpHjAJVGtUUwiAwZP07Jw2uWb1jfgQx0Z+lgEYv6T5uLkZKYllYhHluyyX
         YfVpn9UK1jbWhgXqaOlb5D7y0uY5Vl3qCZvGMk9Gzwz2O0Wjx52G+00bhrM1V1CXl6iC
         V5CVcNawkijh/pNmvUxDbx3H6Mk3HCjXwMqov7llWNlsrqLZ4xlaA2wYjonos3/CVgPw
         dlJfOQLSO2/U9aSkHH/IcQpC9peNCGfaLBKWfMu2pzSX0OXJWynUIf8wRpxFFF4/PCCM
         rnJ3rBcyFuWYVBOeLz0ePzhAumkKH4wDDimQmGRq6i0LFUp9z2GGS/2nKkp3+j7t8Pam
         Izpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842033; x=1708446833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlWc9xQMfTrwQXe+wBhBQiNH1Ihf751q05cKxK+WaTU=;
        b=hHfC0P9dS0l0wG36mcYy616+2BTsC2eSYHcimWZl8t3t4BdWXchqoHiI2spSxpNf5T
         45v0gghMnV/ENGIG31xa9rfc45Ln37hNOMPir5ufyUkARRDiheHIfrseOX6g+d7JPuzS
         lov7H18Ve/KntFc7Fb0kzMjR1N/FQ7v29WXjtbZHyY9mTVylptwFE7mu4Ebe98c5+27N
         rhWxd3nJHbVuM+EReZN9VbtDUeJ+Sw2ezyYTByPxtI0Q0aYQRinPQQrZzEHelsfBGsLa
         gCfK1/OqNRwfoFoBPgJJzwVrlD6RQiOJbdRzlHJbEFgJC3gAVS+mS6A/8cnJDOt9BYdv
         sZVw==
X-Gm-Message-State: AOJu0YwSQN9pHXNf2Bd/cY3PLq16f1rxYfhtn41xCf2RFuT/bF+jLa7K
	NiB9ZNOyNPEAEwu/HLPRyqcNsNyr3z/eFBnA5ob3FxrlbONS3pG1hKui5gP2r0g4leC9BU1JjpV
	+HkwUfjSt4oeBUIg6Zn+yPlErSYNdVEtqhQU=
X-Google-Smtp-Source: AGHT+IEzjdS11lJaFFZBn1XrfAC0Wpd26Fh7AwMedj8bQWW3G1djruCKMXygi1Bq7NL+IVTta0c35TjMTr0CdPv0pDU=
X-Received: by 2002:a05:6902:2489:b0:dc6:421a:3024 with SMTP id
 ds9-20020a056902248900b00dc6421a3024mr10122411ybb.43.1707842033354; Tue, 13
 Feb 2024 08:33:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com> <20240212-decompression-fixes-v1-8-06f92ad07985@gmail.com>
In-Reply-To: <20240212-decompression-fixes-v1-8-06f92ad07985@gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 13 Feb 2024 16:33:42 +0000
Message-ID: <CACvgo50PDZ9aO_PuUbykxL8Q-LQdjEZjWzH-sZUimYX9itH_nQ@mail.gmail.com>
Subject: Re: [PATCH kmod 08/13] libkmod: always detect the module compression
To: emil.l.velikov@gmail.com
Cc: linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 17:23, Emil Velikov via B4 Relay
<devnull+emil.l.velikov.gmail.com@kernel.org> wrote:
>
> From: Emil Velikov <emil.l.velikov@gmail.com>
>
> Currently, when built w/o given compression we'll incorrectly report a
> "compression_none".
>
> As we reach do_finit_module(), we'll naively assume that the kernel can
> handle the compressed module, yet omit the MODULE_INIT_COMPRESSED_FILE
> flag.
>
> As result the kernel will barf at us, do_finit_module will fail with non
> -ENOSYS and we won't end in the do_init_module codepath (which will also
> fail).
>
> In other words: with this change, you can build kmod without zstd, xz
> and zlib support and the kernel will load the modules, assuming it
> supports the format \o/
>

Important part to note here is that the above is only valid for insmod
and modprobe.

Tools such as depmod and modinfo, still depend on kmod being built
with e.g. zstd, in order for `.ko.zstd` modules to be considered valid
entries.
I'm not 100% sure about modinfo, at a glance those tools require
decompression support in order to parse the elfs and extract the
required module information.

Regardless of this caveat I do see value in this series:
 - it notably simplifies the codebase
 - You can use different kmod on the build vs target system.

Namely: Yocto recipe with full blown kmod/depmod generates the mutable
modules.xxx files, yet the target system uses compression-less kmod
for insmod/modprobe/rmmod/lsmod.

HTH
Emil

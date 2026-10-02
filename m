Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E645A1F3BAC
	for <linux-modules@vger.kernel.org>; Fri,  2 Oct 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924797; cv=pass; b=Flfzk2e0HfxPWHgsJPM4UvuARLdEwIQG4Y23s4z2W7aM3sdQMR7MtlegA25prWseGIuuiI/4IzKc3CNYtJZTfFD0sqBtTOlF5bHc/QDRLfeQAOU3nnSU9eEHdFwu9htr5IvCIqA0oGhEFy9HwjX5oZJLV6iKgL4dQA8Y2R2v8aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924797; c=relaxed/simple;
	bh=p5mHTSid7ZHG73d5vk/neGkwUD4BDQU+cFE79JqE43I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STbnwcXHgnrxLjhUK7N/nb+COLVKJPEzVRQiXnhNayhQ0hvJT3hgubSBmOE9JHOOvwdy1Qjqmzn2MPapKnl8qHHiXOn2LvyNbqt7cVWI8QwjW2qEhdGoiwfwi19LPubpFgk+BTxaLgY1ihSyFMMxkYfVyi1PSiEm86IXmMHoVTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfCbAi8G; arc=pass smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfCbAi8G"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c5d196b0bso356554eec.3
        for <linux-modules@vger.kernel.org>; Fri, 02 Oct 2026 00:06:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790924795; cv=none;
        d=google.com; s=arc-20260327;
        b=PGgUML37CaSpK8j2o4zxfIZXEd7fq/www4TF+DKSBELgimLyB7GMbPKDaPeUHHE+Ef
         Ou0QdCnVxrDwXJsBG+ktVkT9YJH+etE0xHgkb0pDWOK/+JnIyYMOwFj5Ue759JLFE3Kc
         LB0kYADHYHECV4PEn6llxzkPQNN12/w3SIQCTFAFoU2KpHYQDHDcCzftdSP+/55X8iEC
         WQP/WAArecE719wKets2U1Qxy178RhdQM9UMb3Talby1pHha7AWQ6pXdJxI4WeTom7dv
         vusE5TedVshmLV9rignGkbg9PcSrM0RrA+mrt/Lcs8s6AW59mBtbw8hCRTdowTBm68be
         rLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p5mHTSid7ZHG73d5vk/neGkwUD4BDQU+cFE79JqE43I=;
        fh=qySSKzzsIPS8N1X0AvDgfrsQk8GcNMZkfgA7mU3YsdA=;
        b=CaeF9sUviLeEA0zhFkC79CYYAL7VxmBlagUGh6x7rCBANqMTdcx7ACXZb2trQKzUK6
         wrvaeKHuA14ddc8fuIE/DAdWxB8YNeTFPSbvFFMUABjIhH+ex2MsjVikouU3d1sOoDKM
         pckFCmcjxNW71eI77+1cLKpPvfiFlY8Z+SDSXPrYDysvkEQCIBiWJoIVrCSJlkZ31vRO
         gyfVkWXGrfOtbqo/YKwSKsFSmpBPBG5urzOas0bP+yx8bVNmn6mSuaQnF7ZN8aCUyF1J
         m1xqsvhDtEMyIUwf9X4bFAyDrlDe3tp5l6MG/mmA0yK5H2Y2NDlLMAP7p10S2sL874wP
         6iEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790924795; x=1791529595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p5mHTSid7ZHG73d5vk/neGkwUD4BDQU+cFE79JqE43I=;
        b=DfCbAi8G4hznGrFWoblcSqWRCssxNIT46MMEbrJ5S3UutsGsLkvze3DaVQ/O8j2fi+
         0B/NSFJykr+lMUIsHAh3x0EKXpMSQykxwm5LtWnVZP23YXhJYeyEwXbcC97oXQKMmI71
         8YRJde+nZu8M/u8Qb2ikM0Q1YeLmu0QV253CjcAG8AcbIX69TAn8bVZ7YxjiJzNB4rNp
         TFyX9VSmuV+zcbdul1Q12k9UNyypiyqY7VsQe14RP4ISvnAy0f0iZ0gc86FWVekS3ZVS
         k+9YM+3F8thpHkd3TzGv6izWCD0S1mKsbA3YN0x6BiCC7CkB4Am/CCwX5A4lbQZ3qS+c
         MqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790924795; x=1791529595;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p5mHTSid7ZHG73d5vk/neGkwUD4BDQU+cFE79JqE43I=;
        b=WRNrM9FNfj2A1L+Mk0GMsdlpmbx2b2I2O8y9dRH+MSdktGbFSL6Tev0eXALkAP5406
         dkNKyJw/uIYUElpCGPK5zrRMd4crK6VkU1uVihupA7B9nBAWhMYVdjnBjtJC62mm0M5u
         T8JfFvLDk7spvWx8VZr5ZvauhzwV2PRDQ3Zatn58XyGqW+YQZ3V5dv+xWmSI6wVu61Ad
         CTQKIuMJ3yVxsVCjS0pKTOeB0tHWb6mVLUdqJsiz4yRWZbTCgIv8cqmUpNukbEmXERlF
         LYsnP6ntC/+vUfhRleTNP4HVJVOc8omzJAwXVGUzpa3mNm93HoNePFHYbqaUybAkCr8f
         vLGw==
X-Forwarded-Encrypted: i=1; AKwUvBxZa2qj6yLPaVuQq0scjrv1Z4+yEALbSuNgz/9SVKs0FaFjb3Dev9EaBY1ysVBUQ6QfBozV653DRjDZwW5B@vger.kernel.org
X-Gm-Message-State: AFq9FYL86NTYeyE08q76uVYJtFtG4VqNWhUJv8seya78sLAA66B/AbUm
	+8zVyfPWFbfoi9qXXeQj5DtzYCfzeGfbe0mFPi6ryRYKJ7ptzONn2Fhrwj+TIy0EYvhaR8jQ5gl
	THNNXipTT7GwbHJV6VAfMlq3AYnDa3k4=
X-Gm-Gg: AYBFou0s2dOQbEGeciSL9r9EfyfKFp63el3HkRSLJc3jDFmk5RmKGFUZCLpVrxczH3E
	Xl5C1G0vEd/hbFH3bsSZBgEOnHiAMb1A5cWQDDJOXNf+j0Z64w612iOvM9ggAiB5B/QWnjWZWCV
	IcOjl2PhT9Xk/A//3yr2l+YPXwYs6WIEL0NwVANhffQ6nuadSXpQj95fjQj0IxW7UOOVz1om3Al
	ryPTiJQu6KO65UVnuR+7lqQZqz91xhdNrGXSAnv+5XUAWBiI7QPOBLmn1BN0LjLSqt9F4ZfSL0W
	ie+CdSks8nwFAlYDSkb+xc/Y6PCP+F7BmgB5ISehEgydqojufkPTFTONFgdoYXF3UYxYJDOhu6G
	/XWkPNZkLjyIqkin7ZygKeciYsWkk53Epva+GeAApQZJNR4mCzYXtRXcutTBSRPY47KLkIitn5+
	hh9CKJQlPjJEd9KRpTacILRz5BDsUoIcdhvPaYoNwd6CNLK2anlTrohiH+6i/p8w==
X-Received: by 2002:a05:7300:54c3:b0:34b:47b2:677e with SMTP id
 5a478bee46e88-34f14ff2bb8mr3462444eec.1.1790924794805; Fri, 02 Oct 2026
 00:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917051147.98775-1-tweek@google.com>
In-Reply-To: <20260917051147.98775-1-tweek@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 2 Oct 2026 09:06:21 +0200
X-Gm-Features: AclHuK8lJ9lWMbMYvuPCA4PNhehiCTluRjGb1PR9k0qMsRR1b7vJrjMUZYoSk6M
Message-ID: <CANiq72=SX8xxCAzf6tcQb1CUoa_f8Y9fxVSqEBsSwqUtfsxn6g@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: allow non-ASCII characters in `authors`
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 7:11=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> Module authors may have non-ASCII characters in their names. In C,
> `MODULE_AUTHOR` allows arbitrary string literals which are emitted as
> raw UTF-8 bytes into the `.modinfo` section, and multiple in-tree
> modules use non-ASCII author names.
>
> Originally, the single `author` field permitted arbitrary string literals
> including non-ASCII characters. When support for multiple authors was
> introduced in commit 38559da6afb2 ("rust: module: introduce `authors`
> key"), it reused the `expect_string_array` helper that had originally bee=
n
> added for module aliases. Because that helper enforced an ASCII check,
> `authors` inadvertently became restricted to ASCII-only string literals.
> Later, when the macro parsing was rewritten to use `syn` in commit
> c578ad703ae9 ("rust: macros: use `syn` to parse `module!` macro"), this
> restriction was carried over by using AsciiLitStr in `authors` type.
>
> Change the element type of `authors` in `ModuleInfo` from `AsciiLitStr`
> to `LitStr` so that UTF-8 author names are permitted.
>
> Fixes: 38559da6afb2 ("rust: module: introduce `authors` key")
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Applied to `rust-next` -- thanks!

Cheers,
Miguel

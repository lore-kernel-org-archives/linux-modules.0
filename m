Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA47038C400
	for <linux-modules@vger.kernel.org>; Thu, 28 May 2026 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958812; cv=pass; b=UVz7eHEbRfcpHWRsoJIKhCsiWfzJ/Fpqrq6Hm6ZZdwhu3Ak6W7WpY6Mg8n6OamxEUDx6CiEGdDKRBbbIXNjTOdbZz6lwh1ybq3lb3aI6+i7mCdf9zXUIdF/HD2WDNXvpnmHaq4Vl4bdnEpFcfGIJK5PVzrh49oY+g51xZJnc46U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958812; c=relaxed/simple;
	bh=aU0+q6h26r4FXAQRht1lGE7YioQhwfVcHJLUY17MEMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxJ9tuZZ5GhY+7dbgMlLWvfMYc5ro0jB1Ah45HXtXnxCE1OEouqBCYRoj0urzR7vdKpSa/flfB6Cpow9xDDx28t5V47y9ezzx0vPMnLrzBXuZy1sEYdhXJvNNjRvlu1tMeNc1eCBQRSRruL//SrW71s2cLn+ffBltgZlqn1vrns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zlb24LsB; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zlb24LsB"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-303da604df1so1155669eec.3
        for <linux-modules@vger.kernel.org>; Thu, 28 May 2026 02:00:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779958810; cv=none;
        d=google.com; s=arc-20240605;
        b=ATN1Wrv0qmyT76M8ZL+1H+qcjTihUysvQ43pEwvt13/8OQR4Yh4DIxJQnvtArxzkiH
         MBchoWvfKavV5IiKrQYshsYDh6arX5fGiD65JYyYH8ot4a6oPEA3hR0cFwyTLYc9d5Hn
         SKJ6bfF/d9zmNCgksWVxMOxfFk2uYL6ZyUWvRkExV3uPuwm7k4fWzUwxYhFO7shIaa0W
         i5KzFI86VkZWxnSoFaxyz8pifyaTIXRYHn0CcK72R+RyJP0MF4ArVPsUcZHXfGQUBUZ3
         MCg4QATf/zachCNzz16TO3yzLVl7qk4RRgM9Cc3hsGX2qgIdndakNyg9A3DD6SuwR5Qn
         ygBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aU0+q6h26r4FXAQRht1lGE7YioQhwfVcHJLUY17MEMk=;
        fh=ODv/eFTHdkNUUeSEeQnITffQGVqVt/mSKHJs4YAyKSQ=;
        b=C2luuAE5uwZTwvcibOcCEuhS9EnpljYpwvon1HwFS2gQsaTvULzEvSkFQ6UhD4lZmf
         FhIgwspr1M4cG8/WP+t+PEYBRzQnblHgZ6+tmdMMC/ImCw06Cjp3ytZcOK3E8OERJZKY
         /7c37XyrGIvCeoJulZPXPalsDZSIqjdSn9G3nVM085p4uUhdHSctbCYGjhGuGc3uqrX8
         hitTCovaREsH24KZ+Fs8+uSLhrvdkaJTECOk9wAHprHtXqeUdTUDBE57BpXvXAEJDeb/
         5UCVdXwD4Tl1mWy8uS/5oN0QDutqqwhlxOIkC7jnGierTixZb/D69SnsZE930IQ7GHOc
         JSIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779958810; x=1780563610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aU0+q6h26r4FXAQRht1lGE7YioQhwfVcHJLUY17MEMk=;
        b=Zlb24LsByV9ad4FXRWmGHURwYDeT7RZgzk65PAXxNAJ1sN9qGBiYnFkEQQdBo5aIdW
         hWjA1xATAf6SkVGBwB8EgG0BFruXdJ8/fHAAtg1k9RS3KEqEsR9zGFWl23qkwaGa1lPx
         dBXB4GXHsBC6jJo8RiE+ekepQsp6wkSPuks4DJaiMyvA12NWmOzVDyke5jT6i5SON9+g
         gInWpDOOpKLPftPBP7o7JD8wmnzKMvMus6WZnf4/MZlRx/LzyRBMfodao6pW3pSrIsYu
         OKvAZf05gVI0xx/SlPcFefS6q+KdtD9Lqrq5jQRPodVmRED4ZLhLPJyB0LEfDstCNwpI
         7AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779958810; x=1780563610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aU0+q6h26r4FXAQRht1lGE7YioQhwfVcHJLUY17MEMk=;
        b=KKaTaM9R6b8Vq4EtHS7ooLNlPTD7gSi63HKNBzex3o62JGC/AmVLy4/IvJHzLdeREQ
         KfjecJZts/xf9ofployirjtjxQyCUxuPx+CpcFQvTRhtr0uK4ZS3VEj0p2OKItLF4vf9
         hbng/5x5FeAP+iTbxNNLxBD/E3iO3atDlzWLjngxGgtU3NjR7S7kH9/jZVkxsSKi8yWV
         lmu++LQB4mf4aXvWs61RIQGbGOFmB87DYiD2IHhP5N4XoztEG2pqqGyTRXVlcllcQLaG
         +E/gKCeBmPndExbNWNH5I+evl2cF7m8TXpyZGWUArJbFWrCWdzSS6haCr+Ovf660Zxa7
         ni9A==
X-Forwarded-Encrypted: i=1; AFNElJ/GdGd6QXsef5jSStcRso12vu9fT/u5d0bUAXshIuw5yAYIzFOoUxEGFPyzi0hOwLbkggq/cwaYgNVqoA8z@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/Hf8JoGINEWxuzCqnIWp0u5g/7fX6UQ79Ah2Jw7Ymcot7HOO
	KkhKVT+LieB0sRvo9iu9G3XZ16ZGjSzxC0nwg7ETrykoZVAE/c2cbidEYq5XymTd2z5DmBdCcW/
	6RJW83Ac+gzEfZ28Zztddwhts9HSObyY=
X-Gm-Gg: Acq92OFxF2rbLRoKHG9pUC/7miCdnK5+2pTTufOXAmK3mj7Zkqos+PVsn8Bp4HSCpDb
	BOeaunzeeUmRpXiA5G7ugwiBA2yHhLibCv8meHOyQZjwNUIIicQJTvO9F3+dihTTZc0fb2c8/P3
	pbXgNVQg9p4P9y8qp36Y7+aidtCDoz0Q7oRn0uGRoa22XacWSZhWWoxJwtCQRmeTyJdP/KEsisS
	jyD/VxaLbHsULRAUr+xXdbBdDLtgfzdukSorxNdQS1rVyid6nR5nbpGDPD7U7zW1NFBR0jhakVh
	Kq1X8PjqcwzjOpnUmSOPR/G9S0Lnur3FP0eIkyLUJasDKPJy5LQXPHk8yrKd3qEUgOuYcxT4O30
	/QnP3cO198ymG06z+O/Xhycmrw+1c7bMENQ==
X-Received: by 2002:a05:7300:6d03:b0:2e5:faa9:ca76 with SMTP id
 5a478bee46e88-304d2edad22mr421686eec.7.1779958809888; Thu, 28 May 2026
 02:00:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521161405.64042-1-SisyphusCode0311@gmail.com>
In-Reply-To: <20260521161405.64042-1-SisyphusCode0311@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 28 May 2026 10:59:52 +0200
X-Gm-Features: AVHnY4KwJu-7vDA81_EynZT2Fhn_w40HuYvwpLmdN038uuozXTwE7stXZRgFkpY
Message-ID: <CANiq72m0K_UUzksuu466s2GhQuXnYYJV24BVX2X8jsk6patF+Q@mail.gmail.com>
Subject: Re: [PATCH] rust: module_param: add missing newline to pr_warn
To: Kenny Glowner <sisyphuscode0311@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 6:14=E2=80=AFPM Kenny Glowner
<sisyphuscode0311@gmail.com> wrote:
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1139
>
> Signed-off-by: Kenny Glowner <SisyphusCode0311@gmail.com>

By the way, we put tags together as one -- also please feel free to
add me as suggester like the issue says (part of the reason behind
these "good first issues" is to show you how these tags usually work),
e.g.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1139
Signed-off-by: Kenny Glowner <SisyphusCode0311@gmail.com>

Cheers,
Miguel

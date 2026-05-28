Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5662435202D
	for <linux-modules@vger.kernel.org>; Thu, 28 May 2026 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000571; cv=pass; b=gk8AcrKTkG7bu9zUjLJ7uKpy/z2mufFBHNlP/INQ+z3VF/omDS5bx7+THz+WHVpGFfVoHOgWrWRP2NzlCQI2WsnuqJS2+r4ANQNZf/N1Bxrf2y7wAXiQWXmxq3VFIipM3WZXtGJBXoLRy65VY2JGkxxamd3sfBHI4c6sF8XhQcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000571; c=relaxed/simple;
	bh=xGbNAQvQGEBp3j4ZoRwqmwavkLnKDyFCVPaptBjC8Vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jppyi0kiWrznGC3tUGUQdDW37YnGjNqgxg9GOhcq/ixH6jW9tZksyWSaOccg4SSKfIyn6QErVGdrHgaWzEaTt0I0TlossoG/E0KWxePYRtsYUdISbXCaIeoeKaStihJgtraZmOs9GCKOOvRTkqPCywbKiHW8bjOSvJpkWN5BjCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GQoTQsO2; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GQoTQsO2"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso64a12.0
        for <linux-modules@vger.kernel.org>; Thu, 28 May 2026 13:36:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780000569; cv=none;
        d=google.com; s=arc-20240605;
        b=NDXoNzqd6LoOvES6DrCVqaT9m0TFR69qS3wYjaIT6t7oOW7lPd1ueMoiX3EZrtOWYp
         wV0ArQmhYHtjAdiXbktxCrHhY9rI9iSHI8CTjqupaKJckRcu1ttukBRWdYN0RNOfo0bh
         olGKMBz82JQMeR+VmFdzzi4zC7siQE5x2NnBwIGCaIZMG6pt3qwfy03XuPfD3RvmlSaA
         RZsDj4Lz761/TLUP0aw8TFjFP+cfUNYtI94uO+hzAMHK2fkmOuYSjyWiiGb2MKyg2RmY
         ivr2tHYmHERf7AbeI00OVZs9b7oHohIrA1+IkJov6y/VrQV6N+VKJm7y9bp6+5l7yRMa
         u8Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xGbNAQvQGEBp3j4ZoRwqmwavkLnKDyFCVPaptBjC8Vg=;
        fh=oZi7+5SyK26Q1lw7lAWrQUq6itSBOmxo1ZzOIzHXYk8=;
        b=Dm79S17xQbpoNtcPWwwkd2IgyZXFRG7lJVrebtCwfyImyK5T9ahyS6XCakbi2Thxjx
         ZFlI72yoHZ3ZkVjOn3EI3TTemm+1yhzYhMbNJboFdbG32n2m3ROJwG/KRFPeEFg1CLX5
         BhV/B1AEWhFIN3G7ypxYRqHNS6ZhYgs6UO6GjBdVf+Rs2X2TrJC19cOnmJlHwzVPRzuD
         FF7GUcNR6tpsfQzxf1PrKCcR7YIMPHeNxwSif4x5t2Ov1TxZvjcwoqGyOcVq1yxaC30T
         wmkiVQ3mj/0JWd8QjT+uvhgAGttRlUpJN4RvXHUDfx31qDIMkmnaauAlzPyASxsftBp1
         pypw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780000569; x=1780605369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGbNAQvQGEBp3j4ZoRwqmwavkLnKDyFCVPaptBjC8Vg=;
        b=GQoTQsO2ENoe7M/FCOQWl2xMfKamYcdV2s0tPC0xTtK2uNgoBMuksUap3Hs3fGgPeK
         2aPV7Ju2YFMPXlHigfhgHJHOaofTmg1lkT4UKK8g52Y2eIvLnbSdumwU075BklUeJlEH
         PKkRlZil/CRfkjKylUyHzky7Fm5Dp7K8rJitFfkSlU34Zo5VsNQW95/OIC7oWGox1BBD
         xijpDeBm5OkqSEEQk+ejHiHciJDRV9iWqFRd01VddlhBV1Y59nQ9MXg/RqbajSfQy9Gj
         Oz432svHu2kCZPo232GPc1wazgpeSipn5U3NY+1VEpm66CsMRHgxb6G2LKuQRlFizQaV
         bYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780000569; x=1780605369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xGbNAQvQGEBp3j4ZoRwqmwavkLnKDyFCVPaptBjC8Vg=;
        b=VwwT9Q7RIrS/IgiFOGkrcEQHCXrZH2LV/vfj+E+PfalpopDNUhmP3Ca14m++OQ1F3A
         zdsmEi2XzL/7BtnMmvC6ctzFUgUzLSUiIo3VDBkXOoj3kB0WM3kHQqHGuqa1WIUgKj36
         GsSHQdCLpiJQfbF8qazaRCCRDpVlr/D+ws0mJbghjIGuh116SAwsl+ksIcgvghOSknaq
         Lo5eoZUZ9+5598HK1a/njM28uJCUJ6zJltl8DY/oHWU/4puT4NXwL/rf8PFI6C/GlzWZ
         Ct1tUN32iresWTUgl9YHb3UYeaV1sR+OBp89WYq/tyldkVn7EqiSVqK8CSEF+9BbkjjX
         DP1g==
X-Forwarded-Encrypted: i=1; AFNElJ9GUACIeq1V54e7r5Evx6E5H0uFZFvCowqtMaYBXrzXPo8GeaLxWpxY3Q+NkvW6T7frg52vn/KqaPAkM5vR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/herWDpgC0M9RFvmxWgB1WoW55mgkHRw1Un3GngK8ANLeQGHi
	G6Ty1fVOZRgebWxzr3wS1P4FTVA/2PWyrNSuWTjRt4eFjwbf3b6ZUVGUKGVyl9jzYe7k9nP90f8
	rknAKOa34feF03uxmF4gx1DUjxbOlHV1w6WqwcXdSEjbXE0D9qYIrNc0C
X-Gm-Gg: Acq92OECOlECfwmvzP3jVUKWshxaSEt7c03jFIcK2auZ51uRqs6wmhuQ1BtEHZi8mYu
	MJbto72sQdZvv+oLGJYM5DjS4U+FQfusfPsCfstxEzlGs8iOwZsoMSqpoTDwhoHmGliphw3NBO1
	DaGzhq4jUwLcyAiMRbwzeb1dzsc14vDqtjG47akpfkhA//F41cFLZzXUME1gMVNTx+7W1z6VHec
	wgfBxkkhiCGMZXKTEEd7Y0xf8DpsqApeRRYOZqXSxn9rRq3wxbNyI97dMupjUkrN6gxRdDFmEtW
	feGU0Kjp330ZqBi6N+BCdotqbw==
X-Received: by 2002:aa7:c590:0:b0:678:a5c3:4d12 with SMTP id
 4fb4d7f45d1cf-68c05b1601emr3372a12.3.1780000568252; Thu, 28 May 2026 13:36:08
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521161405.64042-1-SisyphusCode0311@gmail.com> <CANiq72m5GZp_p2HCgotBaevLmt1NrvzwrzJJK5sLUEwxeVLBdw@mail.gmail.com>
In-Reply-To: <CANiq72m5GZp_p2HCgotBaevLmt1NrvzwrzJJK5sLUEwxeVLBdw@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 28 May 2026 13:35:31 -0700
X-Gm-Features: AVHnY4JqqQSqq5hJ5hUwjgysthQNtz3safYPsw-EMSJJRsw6KfF-J8w6KfKFVPk
Message-ID: <CABCJKue2BvckpFK1yROmOcsrRpxRC9m0OiwCymxF=OW0JZkLUw@mail.gmail.com>
Subject: Re: [PATCH] rust: module_param: add missing newline to pr_warn
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Kenny Glowner <sisyphuscode0311@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 1:56=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, May 21, 2026 at 6:14=E2=80=AFPM Kenny Glowner
> <sisyphuscode0311@gmail.com> wrote:
> >
> > Add a trailing newline ('\n') to the pr_warn! call in set_param to
> > ensure the kernel ring buffer flushes the message correctly and
> > prevents log line smearing.
>
> Did you see log smearing? IIRC this changed with the buffer rework --
> it is still the convention we expect, though, so the diff contents are
> good.
>
> > Link: https://github.com/Rust-for-Linux/linux/issues/1139
> >
> > Signed-off-by: Kenny Glowner <SisyphusCode0311@gmail.com>
>
> Andreas, Sami, Daniel, Luis, Petr: will this one go through modules
> too? Otherwise, please let me know and I can take it.

Yes, I'll take this one through modules too. Thanks, Miguel.

Sami

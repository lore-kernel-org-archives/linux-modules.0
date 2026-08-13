Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9DF3AFCFE
	for <linux-modules@vger.kernel.org>; Thu, 13 Aug 2026 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613577; cv=pass; b=Z5+lmt4azVGhZz9PTn3uUcu9KZt28f7mltkhtCY+MkrYjEqDCfXisPMtYcr+hl0J7bgIlxMcbx9MLCPo9AADruLq6MOabLgQFiAMVyJ/Kldp7FA79aeUz5vDvzQceLhXpgXD/Pj/qLqogIyC8Ot3qAzGrdu/Tqxw+DJK4MMdH54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613577; c=relaxed/simple;
	bh=hxPH+ehBPzRCWk6w7xeKnqdyk50jcH5XyZCkn0NKK1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omtcjjLfBdfunTrjy72wuw5ala1mevCSAISm1jmhcenmyMVgn84w8Vm20l+/d7YFH2+yAmqrTQKCm4uct816HMej3YanPrmL1fnfxnmhp0DWcYwWL77x7Zih2ugyl5a7vwhQ7XTZIJdZ2pAsZ3ryaSfQT8XBBleXB1C2GCv7U4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ki0S4C8W; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ki0S4C8W"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d319b84213so4101665ad.1
        for <linux-modules@vger.kernel.org>; Thu, 13 Aug 2026 02:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786613575; cv=none;
        d=google.com; s=arc-20260327;
        b=g10sVEnN9sUl5rgsiTI39Y9nwc9f8fPWJnI7AIObqu8IvQqfGehA8Ul8O/UTgP16yg
         /p7fPnz6aFf0jouApLrowq5YyeoA0VK8ktzLSJvPDpySC41YF3pvDBv/+Ap84B6k1uHO
         x8iQhHmfbj/BM0KUuAgn8RIeAP1kN5lfA97+bvoaRwvarPbAScUco5XTM6QEKLDHUsy4
         rOTN9CjK6nBVllz2oXYyz5nyaHWv5UcUGrrreWY7tlSqkiiEzEH7ufs7alaJSuBnEccQ
         QFeKWOvEjzv3M7HZzq5VYx1ZjcmYXz1TYrO0ezn6ioEMpbEtrhKr+h/k8HGaZZj7fJZd
         FkVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IxnZHFdFswxuxe1B8yyzSCFANjk8+GYT1StreigHL/8=;
        fh=QbHdjP+6yWkHLONCP3ZYvNq0eub6RR22+Mehxq5NFdM=;
        b=broD4m7qr12G0/2a7rjhx433pH1uQJFze5yI9WG4FnUqoKSpVhKyR/Xw/r8yeqqPj3
         t7k4g8c0OSAsmxefIiFpAfbDwyLH9sKxrYpu9cLfr0TiOgELyv0tWagnT/Mtyn7atF8I
         mM4zlCvNGft2g5kr0W52WFIIt9BZkHgJhYV9m5rH9HybwLjCKZOPxUleXDQrGenbV+xw
         aoRMNtIlj/rjGKjOO9JHBVb8Yvj28OvfBUg0Ep87k/4ea2iiQ549BQdv6h0cJNZ1Rgf0
         MVSM5waHP9Lvk+/Oz/SBcvZ/mJBcUXGKE688KE1OWKVMf5IDZMIbnbkb3tClVm79ok90
         ueJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786613575; x=1787218375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IxnZHFdFswxuxe1B8yyzSCFANjk8+GYT1StreigHL/8=;
        b=Ki0S4C8WDWmasGaotvQ0nFof4wEoVQlo7An0ov6Gl0rUwXMSgg6XVEXZo6N2Goo3So
         O3/FgHe2UfkWJy/r6cN/eGa9shVxGjV8+Bh0wg8UFrL+p1qKMHJ28Yi8H4mkSOrl47YM
         3nAsY5Jw5yPDE6Tl6+UUx8L50Nw2GceIHZWxlSifOIY0qi81DPGXV1vCFZR4MyImM3S0
         9XraUocr2791q7nmxmZZxmE2r7aJ7qIEatOVqrjx2Orojbo0aklqiZABVkTYQ5o/JT0+
         DMg+Ns+B/w++Om6XoscYdrCTs/9WeCwcfWy+JqozQyENao+7695ruzUgy5KCSXK8V5Em
         h96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786613575; x=1787218375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IxnZHFdFswxuxe1B8yyzSCFANjk8+GYT1StreigHL/8=;
        b=EaDRyKlPexGHOu1UHpVA5PrcgRra2HBcwYUjacwuJ/3A+qqTRD5+4ebbVrGud6lWY0
         64XJSHfJv6SN9sW+o5cRUz/EOyiF8mOtL4KRknXJbr0rl5yolCbEsGQuEWdDyao3SmOK
         SvxZFmDszhJQAdN3V4Mzyxc5fB9d7djWg70yu7YGHjQY0n4bHLKxeBCopad3gJ+ndw29
         LPnDKbDCvJA4zzKVMGWdd+3INknorgQm5RDcGzIOC2kCkqnaIYzVdH5DfmHsLspYWJDE
         JfalMKHBtz7PWUsENK1z5YndRZvIXa+GRJyDBJDOYxfQLZZeliGKej5sR+WqQA7q2GKY
         MqLQ==
X-Forwarded-Encrypted: i=1; AHgh+Row+CDY5yNfZHrfxJCJFGYivsuwMwjNhPYni1RDavDFh6dENeH9wiK0vI0yPfT8MWIWcqUi/jQr/RqmBWwT@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqm2Mj88FLG7bCfJ+X4jN8ao+aMTtBPNV/XGXjryfnh7qjgeOb
	t45fzi8XGyRRA6znU7KxfOGZmsf5RgRfpC84WiWPV7zuOcMi+mCJDuTOmeasIMXHElvlKrYoUua
	mijP4/P89tKd8kemRN5hPuMIX3/TIG8U=
X-Gm-Gg: AR+sD13xLVV+i3/vWmihPHoA+WaKmzzDuEvRxt97LasRJM9bf/SEUQ/aKjVVVj14j4f
	1fjeIyJjCN3UVKMkr5wmao9xrjueh588bUDEVfyhNKFLH1QBIrwPZxAQ1AYxSHUzLdzWw7nkoWG
	cR0jFuIuo0A8PbiOrzaL8UaPzYpYC8Q/5YuVm3k9CZVCliuiLTKX3/tP/bMmNVLhdBne7dWRmuL
	25DwSdalGVvr+P7KzVp1Yl8f4/ICvqdn95pbG5t6Lvg932qenGF4Z68BywEtOB7BjHHRTWo93XI
	AQbNjw9HGoZEeaTT7FJ+gGZbvK+iLzF5evGluTzs2Y8rNr5DzyL40p1/vM9t3IqoslcJReF+dYY
	aQJg1uuuhSM3qFpQ6LJOWKg3LkkH0guvOfZNSqbMkwpamyM7EI6jAbQOmXTpIlQ==
X-Received: by 2002:a17:902:d4c1:b0:2d2:a952:2628 with SMTP id
 d9443c01a7336-2d389a366b2mr27617905ad.2.1786613574868; Thu, 13 Aug 2026
 02:32:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
 <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org> <DKNDF3WD27GM.5VP6RBRXZBUS@garyguo.net>
In-Reply-To: <DKNDF3WD27GM.5VP6RBRXZBUS@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 11:32:42 +0200
X-Gm-Features: AUfX_mwSjTSmX5g9cpyULDa32fuXt2Yd5-MIkCd-iXvVUBlQKiet4rzS7F5uPZo
Message-ID: <CANiq72=SP_nT7Z6NSH-GT51-8hJ8qLUa07Cs+SarSFTO9Z7vUw@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>, Alvin Sun <alvin.sun@linux.dev>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 1:57=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> IMO this is the correct way, also consistent with
>
> https://lore.kernel.org/rust-for-linux/20260811-fix-fops-owner-v10-3-7e71=
776f9dbe@linux.dev/
>
> It might make sense to add this to rust-next.

Yeah, it is also consistent (in the sense of adding a fallback) with
the other fix I added when applying the series for the `macros`
doctest; and the `kernel` crate is not an actual module yet.

I guess yet another solution would be to have an even more local
fallback, but that would be too local in my opinion, i.e. we will want
to use it elsewhere sooner or later.

So I could fold [2] into commit 98f256e27262, but a commit on top is
fine, I will reference that commit from the new one instead.

Ok, done -- Danilo, I took your diff and converted it into a proper
commit, please double-check you are OK with the Signed-off-by:

  ec6fcf8a175a ("rust: kernel: add `LocalModule` fallback for
`#[vtable]` `impl`s")

Thanks!

Cheers,
Miguel

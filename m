Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795210479;
	b=zApjiciWn8G1IhOjwfc3zqHqFQKlouWx3CpttIvB49Uh4KjhsPZ3UrOTcohfS8vV5+GP
	 G+WsSVGJLBFEfgNcK2ocbadHMzhx9GY4SEmOXDMytelOfmRXjfF79NN7YIIrsFx46AkCg
	 l+xPsoqo13+suzXizAsvgChIej6bWYMh9n33Ar02kcPqP2FJGzIxRwIXYLusurT3l/0Wo
	 8KaigfAMNvF8d1PO0BbMI8DubBdFWVSfLTbYDWrGhjaFyy+afrMFZmbu7xZZ5+D4Go28g
	 ASp4RUZ4M7v9mtR8MKumur84IfJj4pWdtR3ZWXkcRivqXUtsgNsoddbB0qcToe4v3DA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8ybDpcTLc48ilAjH0O6ivdBYWvKm9L7gemRZOYABRPk=;
	b=BWwoZ+5fpmypocJTaZ3NAUD0/496dRl/TZuUCREX4f+robSAacmx7ZYpsbocLRyamMYl
	 H3zre8kQ8mUoUDQzSzxLoAhzgI8uBMXDll4vfb8bqYhTDw58h+jWBTdRaFU2NBgtZQ7Pk
	 fBDuikpIBVKtwmeqoN9I/FlVengPKLefT92ygpcWhPrQjVsq79WdpNLM09kCZeb1x9WDf
	 4P7GNtEJYbp1IFZcR00ESqIQm2JsWzVH7ePkY+cO7jUZdho0gmEc8pgAyjJHRFPGEh3oa
	 bIN8PMmPuSFi53U/Cd/ClMjAde4SdmmfLZJPs+W6Gilk6R8XfiyqH7karzkQsMDgEOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HB+I7Anq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B188606A68B
	for <linux-modules@vger.kernel.org>; Fri, 20 Nov 2026 21:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B188606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HB+I7Anq
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5c00c727a21so46434e87.1
        for <linux-modules@vger.kernel.org>; Fri, 20 Nov 2026 13:34:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795210477; cv=none;
        d=google.com; s=arc-20260327;
        b=kj9Dkxd3FUjSYU11qqlstukQs8VRB5gDYQKg1aHMImsYyabEG/bQ37GhCcp9q7nQGo
         OUdaYb1EfmVoZal7G+0Y6vN1FKSVX2dXDcs3JzGFvREMDaek9XmY2mrX0Ry18o+q0qNU
         BvbWdZZoy+5lwbFV0IftrxfWaEjIQ8sIoBtBha/fwYcFTlZVyOnl++DnXJEe5F+JdvKC
         D9X7ybJUJwKjSvxG+pMpi0yYqJ8Dh5pxY2Up4Xklvs44xz79cls3GrW0dGkL7zUl1URA
         mu4yAjq390+gnqTcons/AfLQUcDEB/dhgY1XSeCxT/BJelRZIWMllQhGue9FcsxghI5t
         kdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8ybDpcTLc48ilAjH0O6ivdBYWvKm9L7gemRZOYABRPk=;
        fh=j2cpOqdfu2xSb7kaVm6scQIOnduFFuhBX6B1Of6KVQE=;
        b=gY4F/Nt806mEnYvgg1xIyLcGRQjEtp3HCg735x6XcUL2kk99qVuhD6c5BxajZXqH0q
         u04Pw7viB4s5SP7J9fKswguhagnGuRuSVW7zCXz3sf6He/pTcDdosGyaptuV3qBdbtt1
         6kh6R2OaHu810KC1imbhnlNZhZZ9uAROwjGWSbJYn+Ep3qF2Qi/N8YYxSU+Dxy7OYALs
         sg/wdkBbjKsRoIz692GrmPAw4xLT0M/e5zW/dwPI/tLXAsDILcMHWYR0VuDwGJeIMemW
         zObdCOH6eu288S8IVYt/BJFf9C6d6LEHB3vrOF01DCPcnk2o690tuINB13pu3433H9PS
         DNOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795210477; x=1795815277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8ybDpcTLc48ilAjH0O6ivdBYWvKm9L7gemRZOYABRPk=;
        b=HB+I7Anqk8a0LDDlLIYOJaoJreFMMqIY+QYMOorsLogFkuG7OzQO/A2edDDVMNTo6N
         1jRF5SLbDq91vi+eRygoxIL7qtuiJy5+cJ0g0aDRWzRgP7XoqsAGNWdVjTTTjUmWGfYK
         iiMezMoIQocPUOMcJavvaxuVszqAH92Ri1lCIiIDn4HjBos+iXMAPy2qUTSKMZofY2l7
         fidmz5iN+Q/G8nvtUpep+Sqk9X8+2SesBOwQqky8Y3xavoh44aPDqVd3EA2Gl1co/EmY
         x5yOqQ2fbvIrRKR5ACugdugikV61qEUhVzU7duNsOFNGhb7IhVgjZhxSjx8j329j6Efh
         SlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795210477; x=1795815277;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ybDpcTLc48ilAjH0O6ivdBYWvKm9L7gemRZOYABRPk=;
        b=v/6DiD2d0xLlo6CDHsn6n7G9TRo+7eUSNCQgsooaaLYRgAJt1gp5XkxChZsMllNJ2s
         bAjGSW+CNX4oviTHU2NWRI2+gnjqwsQ1lWqvHGTLbNuhfHg4iqWxwwiZbA2x7BlLP2ig
         qWeFz98AfukEB8wXXPP+VrvGPZXDT3G+B0kAUIKwK6SMuiYor7PspzN6AiJkcMki6yUB
         16nCCmcKpzRJCpyEREnQVdH1qBXXt8NBvQNebRW47HXG6UOskrgKdc5i63ehTo1qQodl
         G+lNW8oD6QQyoXd01GV6hsVwSXjwKzavqSULsZAr2TXqJXe8kA6WQJK4FdiuST+gYH/h
         qaEw==
X-Forwarded-Encrypted: i=1; AL+hErH1zZ0OY7HE36bZgcvtHAR6LxvxUJ7FaW/Spz+WUIycWwpjau7wG4Q6S2sICMhuxJruMm+e2zJgvGiDm2FT@vger.kernel.org
X-Gm-Message-State: APuU4Z9DFbBxgEikl06Pp99owUrqfYRNaxSeW8Sjy3wPFf5Oh+oGMYaz
	qcMo5GLfORkQEcUnq7VNE25lPtr1jECdf7d6HD3LFYhmcOomGifPkCoRclbQ6ije/u1WqO5Q52B
	3KB+QhSeTl0otcizM0K5MB5KoSVtsKjY=
X-Gm-Gg: AZFdTZe/1ZTSVcejaGIRKZB1CEHeJAZR3TgS5Ij78i+EEMJLr24XdvuVWVcRlRekzeo
	zUPZGl6kddUB7reZg43JD8E6fwMWj8drpdZgl6GUkbH0DSyPCUHwycSx00gG0NQqaXyn8cSRlXA
	KnsMagttwqynaDY3bIcoW5yyh13Sk4OAkqFbRCPOuaJ+YJk9LBbdkE7Um60bo9ODdG9hU0v5gqC
	qhz8ZSfRBMPdkHe7eOSAcFfO2LM9VWcoGWP1syldyhUvor4bcBS4a0vixhetrxn56q5Fh0URjbe
	9Jl6pt6w+KafgtR7sJfQrtQfQOA0MhIkCnpYAF+c0W079gzPUQSKKSePRpN4lPsmrqdoKHezEeH
	XepNOudmXXAV+xiwglZJKRmGJ+xzEUx0iqHnVi4wdk5M/JjsUWUKQyUhg6RxahGNjByVw6CgAWn
	M/rgXTq//62pbMFM+v7WA8R2nMBTW+EyyvGUk3kbt3u1loC1k515NqeqFJvhHO07V1QbXLDQSYB
	haKerQfI4v3oYTqZPw2ciLwypaQg/Bci7Ux0nIZVlSZHOlMjiFjRDedDF4cQBDNgA5tmpmUMrUA
	FByEHc2+i8Hp9OvVyQ==
X-Received: by 2002:ac2:5692:0:b0:5c0:ca1:46c6 with SMTP id
 2adb3069b0e04-5c1bc7b71b0mr1742929e87.4.1795210476660; Fri, 20 Nov 2026
 13:34:36 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-rust-helper-namespace-v1-1-3b9a05553ff6@gmail.com>
In-Reply-To: <20261120-rust-helper-namespace-v1-1-3b9a05553ff6@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Nov 2026 22:34:24 +0100
X-Gm-Features: Aa3M54pYIKS8y5j5sPhIHPrhwaCObEpFTxTtsZ6oNI_ybFTVM7rT8kqynPU1RAw
Message-ID: <CANiq72kWXzP1SWUvhOT2k-rNjopnySXeBkjwrx63V2QUaLpnGQ@mail.gmail.com>
Subject: Re: [PATCH] rust: put C helper exports in a dedicated namespace
To: peder.bergan@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 5:32=E2=80=AFPM Peder Bergan via B4 Relay
<devnull+peder.bergan.gmail.com@kernel.org> wrote:
>
> Suggested-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/216

Nice, thanks for going through these old issues! :)

> +rust_export_macro =3D EXPORT_SYMBOL_RUST_GPL

Do we need a recursively expanded variable?

> +++ b/rust/exports.c

Conflicts ahead; this file happens to be going away with:

  https://lore.kernel.org/rust-for-linux/20261112121512.1670347-3-gprocida@=
google.com/

Cc'ing Giuliano.

Also, what Sashiko says seems reasonable: if we do it this way, then
we may need manual `MODULE_IMPORT_NS()`s in some places, which may
become a bit annoying, even if there aren't that many mixed language
modules so far.

Actually, perhaps we could just import it in modpost if a Rust module
has any Rust translation unit in it...

Cheers,
Miguel

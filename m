Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F383BB11C
	for <linux-modules@vger.kernel.org>; Wed, 24 Jun 2026 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309790; cv=pass; b=b+MXWVRdD9h0ztdtIAvd5DJAUe/pf8CceRwpUwoaACp2Blg3vgsPJ923paSeI6tjILEHqGUuvMnYq1tPbXzBIlWaT5UOJKBMCor2A8q4cBh42D1ll+YxeM3i2RDfd/+8IyTAa1yExF7SDzxGjD/XhJiuvoVWWvSkQxNK6Uy1wQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309790; c=relaxed/simple;
	bh=ksijtf2IRLNHsT3AVS8XAMToSq3zWqz1VXfdch2/aYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNEskCTdSN6BFzS6D9m7ehguj8CcMRMMWYP+yMwpQl9r+UIbWppMyRnOC/lRJW8DyIMu1GjrhElOyll1eOv0u3xWbOSk27Lu6e8cPQucsJKRt8KXHFryMpZkiMPtioXuoRWVatgb+PP7Q+6XrL69Vz/+ENZbdZAzb8wgMw4m0DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOD/uamh; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOD/uamh"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30bca8ef052so95367eec.1
        for <linux-modules@vger.kernel.org>; Wed, 24 Jun 2026 07:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782309788; cv=none;
        d=google.com; s=arc-20240605;
        b=Ri1LsrKQNM9ChEnoXlXs5PHbsgSSL2rSVJEAsO4Zvt/8Z+KwoWlw+kTtE3gntNsw+/
         yhGJ1fY7hcvtHVssfyT8roCbXepz/5GeleD3dOtSAxJK6eUw5ykfnvmAkoFN+3uODKvH
         xK6TUFH+LpwHtMTY23a1+k/M6kYY33emrAmZ3Svu/otwjz4LFqXaNMyoWg3/SAqSo3h7
         o+1c5r0nA9RYrBNzIW3omctevCM6Qrgx7x2VMRUgKEjlVG1bk8u3WgLbrAFiyhWTBL7f
         D11vDygF4Q2R37cq8/Imi6FiATlZkHS4YX/YYkQQulNAxFgLWcjjyy5BvllmC8J9rJig
         tJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ksijtf2IRLNHsT3AVS8XAMToSq3zWqz1VXfdch2/aYo=;
        fh=QCN1kqbMKa8cH170cwjuoIcULgHjsnw8eorYsfjrdJY=;
        b=CgAnEcP0Njesvy0C93l8vcv0OrtO/WXPCx5ecFqtijVUS7WBiBmwmLMeFLM3T80ygK
         ZjT5wNvQmO5A1+56e97DEKOCyhfoK6MsFthN1TeUBynny6M+F/B4QI5s6oLJBeDOyBJx
         3E0u5O2Q+BpfauFdKdyoKsRYnt/DS7C14usZuJ8X8oqoKCEhhmITEMQQ3dijy1OKgxmX
         JZfXbDLcw10T0DEt0UTdEZXxgkNgxlq/Z8ZbJC4e0BNKZ0U+XJ76utVElP4BpvRNCKtG
         Ul9vzRv0/+TuyHlcrA2Z7/MwsbHz+cP6js9MvGCjjqfQo21ftqWeYZWTjygXSdufYZmL
         aejQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782309788; x=1782914588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksijtf2IRLNHsT3AVS8XAMToSq3zWqz1VXfdch2/aYo=;
        b=bOD/uamhEpcZJyswv53R84IDRMeI6M5+ChYBgjLyvLfT1fQ65r7lzzwQ1gmCC+wuEn
         2vpGRI+m5uC/gsBm7DblfDULWdfIY9ZSe05VXEG08w57lGrNtLwN60ZcYfsqhVWvylng
         bWEK2eVdZJ0Tmb5pCGX3UXUiIh3E+i6++a9NhVOOHmx/n5nJ0rOXw2ASWQ9fgoOTVTCB
         3/28G0P4l5fMK7R9as4EUjduvq28vuDMkk4OmSZZcOF7jdfBx/hM62MM+5WWYAjBBcyO
         /vcLrSxb4845JDcnkXx9wDzYjuWeHm0U98NS/Wqidu+uHZFS1rgP3ozC2XHYFw/vXnIx
         udvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309788; x=1782914588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ksijtf2IRLNHsT3AVS8XAMToSq3zWqz1VXfdch2/aYo=;
        b=AnAZ8o8uj1wdahLcO6+nh6+rL3PAekAqQ9C6YCtx+vogzDAhtScfrsZ8D3fenXeJE7
         14uToEPD3/6eBNifePC9DFMN2H7J9xPOeoSZWVuZqPGO9AnMrW8FxpEzUVDT74J7+qGd
         JaQI6kwvhPey7kZCiKA4S3xGBEaU/PoW7LslXu/d7A3iFiUgCG8nbC3AFj88TLlgphVU
         Wb7XjWt6ipgPB/z9VZPhKpcjXuWhST3ruCXrE3tlu45PyZwMpSSSqSf4yS28zatVMX5A
         tFFq+huJyolHGOHGhsc31oyCTPsXpLMqlB1X/qnrKQIdzdPZtOQ+98BWgIJl+G7AYs0V
         6pIA==
X-Forwarded-Encrypted: i=1; AHgh+RovCL/PzZkNkZtQML4SqtgS3eqE8x6SLQlR9vrfhjKkCGaKzQIVFxXPHbO+psu8yMIIjvwcxlElq/Trqc0q@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfr2mLL6s0c4lq/tc3tXDqwj8LUFltA4qGJ2PacDNdMN9BhGBv
	h+gz8ifiIyG98Bbv39C6+2edVDLKYzt4sOtCGU3KWi8XhfViqBoiFRVboiS6LCzmzpH/LMFx+C2
	Dvht+IEp1nH4zi9rNE9mnldPtkp4ufcE=
X-Gm-Gg: AfdE7ckEJMtAywuvrRpB2K+OZp81ENzeN59jYAs2IatGpD4nwSKTXXfroFS7KOXjrbC
	yhvoMrSTymzSACb9w5/aqlysZSkM1nCRG7yc/yV4LJCQ/a77vUzSsSxAkqBpcDwMzwtZKJA/+62
	pPA+ZGQZLXEnJ+AqW4am+3NbzPiJRNpM4EvTthFmmZ1VFFr26hkxNJKzTcuUA+77miW78Wlctea
	g04QwbhYvBegJkPGG2o43zXu4VZA2LSU1hJZhMGL31BI+vlZQ5bjtBz374/0wypcbfhowf2SQW6
	WG1L+tkYN9EO1i/IXUhjE/X8PMnTGURc9Q4IiZU+K/+oS28scGwRRHChAM1viNCTyNKoB7qgSCP
	DBOSUDv/w9k/e
X-Received: by 2002:a05:7301:658a:b0:30b:c8bb:588f with SMTP id
 5a478bee46e88-30c5240f7damr3538472eec.5.1782309787929; Wed, 24 Jun 2026
 07:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624-fix-fops-owner-v5-0-aa1cba242f05@linux.dev> <8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com>
In-Reply-To: <8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 24 Jun 2026 16:02:53 +0200
X-Gm-Features: AVVi8CdZJD474qdF4GDgFLlfJ_vD8WsFaomaTI3YSRH6pluhcoRUR51gh_iz4VE
Message-ID: <CANiq72m_LakPxHt99+3eBn2rXokr3vZbdJf=Wk-Yi8_ufQ2mvA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Fix missing fops.owner in Rust DRM/misc abstractions
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
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

On Wed, Jun 24, 2026 at 3:23=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> I would only suggest adding the new file rust/kernel/module.rs in
> patch #1 under the MODULE SUPPORT support entry in the MAINTAINERS file,
> similarly to the other module-related Rust code, so that the module
> maintainers are emailed when changes to this file are proposed. I think
> you can change the existing 'F: rust/kernel/module_param.rs' to
> 'F: rust/kernel/module*.rs'.

That would be great, yes -- thanks!

Cheers,
Miguel

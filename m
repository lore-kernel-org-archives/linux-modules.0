Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562296;
	b=Py5mhdC/WWlJskZ8kSUSNlkZGZQ7tCP74Fj15j9MqobF0MvM6LxIFwYKh5NdXkZnn0PF
	 lUx9HfMe1ULQyyuwrzfg12MHEtwWNmHJadIGDTFSvLvjsUZbFRO3qITIF/bs8Jf1g0/av
	 NWbRTKtdbTx/efCWmDXL16ytVxgguehegdyuOZ4Tw1+QalHb6PrE5s4pbZie2tDDFzeR4
	 xaJeDUY/CoeSfeOiU4fcJMX58z5GiM6nVpImCzJ+lNOLruUK4iovKkHj+sUSe93zMIEL3
	 eTIuZkkdBu3fVjLk+aVQe71HDpzpGQBjtbphVE9bON4xMCjarNGYu6D7M3wGFr+CjZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=tYh8DQKbiETTaVJq9yQgdC4K/jMzt2M4sjI+EyJr+h4=;
	b=4k/MVDiDeSLiyCydvsmEtGh4iaYSaKcEMZ7GP00Um6ApIwieUEtfSDIgx2cgSUNsyXbf
	 qzDEPVj+u3QSPQir2yFjjYI0CxB77O6aUASK0M1jLeSGb6dRAQBGKUWt36pBJBV1UmzDF
	 cCxaCUKY/hwH6VU3wq+84BKltdhAXv0lxcbaTAUOnaCDxo7GYOIaYZg198A8pd9KbRj6w
	 wOMrvmeK9KC9huXOA6Dg2XJBwRQtlQ1fAw74UDb2kMJroGoUreIQDiqA3nW+TaQfE5PKG
	 nnDASDQ6mTyJuuw7q50oJV14G+ditoTCXHLqj637oLfM2k5BU+bcH02/LObKOTplP3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hE4bSa9w;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A06E606A321
	for <linux-modules@vger.kernel.org>; Tue, 24 Nov 2026 23:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A06E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hE4bSa9w
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-533202fe429so1091411cf.0
        for <linux-modules@vger.kernel.org>; Tue, 24 Nov 2026 15:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795562295; x=1796167095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tYh8DQKbiETTaVJq9yQgdC4K/jMzt2M4sjI+EyJr+h4=;
        b=hE4bSa9wgMc5JM80e/QGqpr6OLPMNLJuOlAsIpcTIuSkCeNwSglPdNXIcxLIHOwE6j
         yd6P08ZnnL42ogei4dEu8g6XNqRQT8SBdjDEjO9uYwFrj4JzSxYcvQ0agRqnYK9C52He
         /1rEors4xObnUGFqxEz3w97iUwo5uueqDIj1ogz/6UKBRIcRPeJl0gxqsoWxCkneqabq
         6Lw6YEIXK8WTbHIklZyui25SvF0mb2br+LV+H17y2N2OibnyM5RVOCcZqKbUTdXlKikP
         4yxzB+bb2/+0viadqaRyaH+g0Kg8V8P9BfbmgBrs5j+ZxRX3FYU4ZQOUxPoauUo8mvF0
         BzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795562295; x=1796167095;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tYh8DQKbiETTaVJq9yQgdC4K/jMzt2M4sjI+EyJr+h4=;
        b=AMtuZIOlFQ0Ec8sSkJJyp/Ezc/Iew7D2DIrqR68r/qFw3ys5y31gwx2CT+VLHJaNql
         VOdwa7L5n/IGYpoeHlD4WjEuSEpNUeuhqfQCOkSSZLdGocLElM8YF/vjRJsq65LjaIsy
         HkvnpuqsATxHPmdMrntNwNjBlpReTv2INK9ApJOzKB2SQ2ZFEYGJtg9Dmgf+u1HLxj72
         Zl2/dsb8U2k3MMZ28fmcXAxYEus2BijoMNpJNB6+5xw31NHNx0OSVvPgryHYj+0SnfBv
         MNy95dtjxHQkUjM8ZKcbomMGRDRw80iAr21r46R3dWlQIXcMDtwt2+IQrOgMvIPmApmb
         M5VQ==
X-Forwarded-Encrypted: i=1; AL+hErFD6Ev3/PUEHg4OEZ6SEUlfEQ6lcoJI0RBtA7iUfLJj+aqwPm1Vo50QLAxTwriyG8VCTwuGFMi+wCO/t1+t@vger.kernel.org
X-Gm-Message-State: APuU4Z8a9F/fDQGuMRpNdlXdL4wOWe63rLU+0hpir+eXjgqwLjmmyDz1
	rUk+8BOxtVSjLxufwz8zduNwsI8dKi5WsOuIhwtfikMSYUcAGvOyYpBLaGA0xNwVIg==
X-Gm-Gg: AZFdTZdWc3U2kqV7x7a2euYZOq9azkeNx/EViNMPERp4vwu7b0RHfZ78fcbA6UFb+Ps
	q6QSmdPbLULrRVE9ulVF9jyUJGt/v0fKDq1/wdXYa7F7cP/FE+SLIWPBW9JJSwY2uEFxR8HV6wh
	1uaQ2yolbPAGgxj1enfCYfJ6oQn/PJ+LGaI2oue9U53LXl0Of1uJy7bKcaKH1nNnmZQ2aEFai+U
	Qi6mE1bo8+DlytItgOJ6ZlPMKeg4noxv8vxqHrOvQSTMehf1mspgGTRdTWxRvubMlLsmKAIp/uV
	Db0EokPWZB2D3qbrEZlTCm340M8IJuKPylQb70YiRlL9haO8tqK+tso1ymy0DinQDk9jQYJIeKs
	1aZyprp9B1M8lv1g6MiElzE7a0MhCIOgVD0VcQbiTQG3vu+FkRKu4y+HKaieFAHtrITGIl+qIWe
	/wcBLteddgpshMmyZ0+Z/USJo2+9LToF6Asi3YvGQ6wl6jY3LFrytOKSukvE99Sz2Z19C39X+7C
	MWquyk5HkDqUK+pe4CQBsxVJccLLPVVrvy4V2EdE3x7R7G/L0ZS7gbBq5lo/93MTGbmXCFU+W7u
	AW29aSIYzBTdyCxM/fWPGkwha1c3zNw7M3tBLBIULG1Kz6ya8Nfb8wHFv8ct68o+8rQ2026t
X-Received: by 2002:ac8:5cd5:0:b0:55b:d494:187f with SMTP id d75a77b69052e-55d881708admr66731661cf.5.1795562294169;
        Tue, 24 Nov 2026 15:18:14 -0800 (PST)
Received: from google.com (15.79.125.34.bc.googleusercontent.com. [34.125.79.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7888fb27sm137434701cf.25.2026.11.24.15.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 15:18:13 -0800 (PST)
Date: Tue, 24 Nov 2026 23:18:07 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Giuliano Procida <gprocida@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>
Subject: Re: [PATCH v5 0/4] clean up EXPORT_SYMBOL_RUST_GPL
Message-ID: <20261124231807.GA1736509@google.com>
References: <20261112121512.1670347-1-gprocida@google.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112121512.1670347-1-gprocida@google.com>

On Thu, Nov 12, 2026 at 12:15:08PM +0000, Giuliano Procida wrote:
> This is a complete rework of the previous series to switch to assembly
> as suggested by Gary Guo <gary@garyguo.net> in a review comment.
> 
> The first change in this series is a miniscule safety fix that will be
> obsoleted once the Nova driver Rust symbol handling is itself cleaned
> up.
> 
> The second and third changes switch symbol export to assembly.
> 
> The fourth change tweaks a related test file.
> 
> Giuliano Procida (4):
>   kbuild: respect skip_gendwarfksyms in cmd_gensymtypes_S
>   rust: convert exports.c to assembly
>   gpu: nova-core: convert nova_core_exports.c to assembly
>   scripts/sbom: update rust export macro in nm parser test
> 
>  drivers/gpu/Makefile                                 | 11 ++++++-----
>  .../{nova_core_exports.c => nova_core_exports.S}     |  8 +++-----
>  rust/Makefile                                        |  2 +-
>  rust/{exports.c => exports.S}                        | 12 +++++-------
>  scripts/Makefile.build                               |  4 ++--
>  scripts/sbom/tests/cmd_graph/test_savedcmd_parser.py |  2 +-
>  6 files changed, 18 insertions(+), 21 deletions(-)
>  rename drivers/gpu/nova-core/{nova_core_exports.c => nova_core_exports.S} (62%)
>  rename rust/{exports.c => exports.S} (72%)

This version looks good to me too. I agree that using assembly seems
cleaner.

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

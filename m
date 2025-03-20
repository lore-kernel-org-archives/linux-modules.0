Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BF712B73
	for <linux-modules@vger.kernel.org>; Thu, 20 Mar 2025 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742474883; cv=none; b=Og+SkncaNigXumLNNQhtXAZZnzKyhWqDmzCKNGBoqQkgiFj7P8UEMkRiknEKEpkChWReDNqjjuM5XO+2Ox8C/d3HmRsA9aRPRDsVj+ecJlj5azN+VO35yZWvaBOK6xpSfFRnKsvTBhXNJclR65bSh7wgq2BK2MyVM3jEWdKjLGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742474883; c=relaxed/simple;
	bh=IDXJl1i8J/l2RNFsvY0vgM0l739CZxYxycHd2ToDpb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cdm89Snjwf2mXjlck3M+Vmr5W4N/ZoEsioEmydU9wu5cdiXNQGXscRkKidrlxwb/v0Bl+lulRLsEQuuos9MO8P1dfeO8tEaEeJ6t93/CBwHHtZA91QsNqhiVfqsPvakLZfaqRAJ0MnYVUawI2RB0g9ptzC+T46Rgiti6o6MPXzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PvKhbGaB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PvKhbGaB"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394a823036so7319685e9.0
        for <linux-modules@vger.kernel.org>; Thu, 20 Mar 2025 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742474880; x=1743079680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRTmEzyfg+Wz6HIOSkkIOgmGqmh0KFaXiwIBIUrCw2k=;
        b=PvKhbGaBGw+zOo34+cdp03/WbjbcwwhOEEjLib/s6Zx3BkvkhBWFlTSK5iMHfsSLbb
         WD1skXKZBqhuAMl5ONYxYizUvavv/FCOUDxyvpARuf2OXA5X5NyVTNYtSd0zvkX66zru
         ie2tV3jQdzZTFSUkZbtxpNhgxR1xY7P+hH80RdWf3COONqCcirJj9sJ5ObTRLSxnJz0n
         1XNkyT6jZiIzJ8+OUtqiX67lywSQ4s/05Ok9TNi2f2KYQYlMCSKyIbRQfV7oBAqnDD7U
         eiSWkdppj4ea4m2LjW2OXkkSB8pM9W7HrX8LX/Zb8/7i7VEN8Eb/SwAm6ZIMysj4J0NX
         Wo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742474880; x=1743079680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRTmEzyfg+Wz6HIOSkkIOgmGqmh0KFaXiwIBIUrCw2k=;
        b=ACpDkVzwgvOa94J+iNz0uotcB1EA78z9Kqg0DJZeXVaQwpInWdPkP9T82zVdjjV473
         lmZi0rGuDgQvRUJMX0ojo+XroMiV92wn5h4Ba31S5cGBTdVQDQ8e5hqza00bFwRsiOyy
         7hCdBRSKWUPld/P7glceeAzpGRiBsBBdn7pNlzvB0fTVDd4tJf6aAlQBRPZBj450N61V
         Cq4Kg0uguFa1SkrNtLdHTEJOC6x8on8LL4bOIQ+R7Il4ECe4fcuyPuPKZiydTuD5+Qsb
         Sa7hsjpEd5u6I4QKjjDOg3RqftBlvA20P+nS+rLjl5kmHKigDo7PCEkIvs5wrbXsAKiQ
         B7Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXNjdWwdlaEAK470tEKup3Do9Re8A9idY91p5yNuOboL0EXejPChjMt1FxTkOmALq9EvKxdC7qHcK4IScNX@vger.kernel.org
X-Gm-Message-State: AOJu0YwXbi3eeZPSS4rDE/v6+0vf2VHFCMVKMVXGw3BoufmzAQJIDZzH
	GvZlqsGhzV9Wwk7/ebHKbTw3ddSb9jZ4b5hGjj0uUtnqbI4V/5Ij9g5vcHopBFI=
X-Gm-Gg: ASbGncvU2vKeerK6gUQHoYJe9Um0Psb8Fx8wufM6Y6miTkI7u/Y/CZwmEc1BOa5N/M2
	eF3EpgsVqnXL59xpfco+8gYl5/LyDu7OXgcyFLCs4BggQAS80uMm1kctCggOO2ot3RXKLtbQyT0
	RSFYlFIRMAW7k9p5hx3BEpGrZJNm90Je/+4rioHLjR35l/3vI9cE5q/e2rQztSvi7LStyppGLGW
	V3Orw7PE9HqdcFNi2MTiZCvO4wK4HMQRBxZKzixkPC+0qhxZ5uN9N7r1LwwZ9ACsHrZLd2tCjfB
	4E27QLNezVKD5jiEUIvyWPG6o0+ZT0NK4+PfH+gT7wUCzSOI
X-Google-Smtp-Source: AGHT+IFK8cnKd03UI58c58N9tTUhbs8lTuMEB2+nvwJxneGk0ZnWe422V+Lm7Z/j4ELAov50+NMyvQ==
X-Received: by 2002:a05:600c:3b92:b0:43d:1824:aadc with SMTP id 5b1f17b1804b1-43d438a1d8bmr63258995e9.29.1742474880123;
        Thu, 20 Mar 2025 05:48:00 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f589bfsm47675145e9.22.2025.03.20.05.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 05:47:59 -0700 (PDT)
Message-ID: <efc4dde0-66f0-45fd-8018-00e94c3497b8@suse.com>
Date: Thu, 20 Mar 2025 13:47:58 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/7] rust: extend `module!` macro with integer
 parameter support
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>
Cc: Daniel Gomez <da.gomez@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Alice Ryhl <aliceryhl@google.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Luis Chamberlain <mcgrof@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Adam Bratschi-Kaye <ark.email@gmail.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 Greg KH <gregkh@linuxfoundation.org>, Fiona Behrens <me@kloenk.dev>,
 Daniel Almeida <daniel.almeida@collabora.com>, linux-modules@vger.kernel.org
References: <20250227-module-params-v3-v8-0-ceeee85d9347@kernel.org>
 <Q_mSCTsSMDQ6DylWZTrkH1Wru3fQ1LFIiuk1pHElSsTc12fDdaCrgzWvEEQRE2_WBxOBzPuCE-qBJjw7LhHbjQ==@protonmail.internalid>
 <nh23cbbpf5yk6mafn7gz7urlau22egilideytnnh7paagusaih@t7y7q7jha4fz>
 <87frj8dmlb.fsf@kernel.org>
 <CANiq72kyAx=wbvYWBTmPb4eppfvGuFsjVMa49nZBrXGbLEDiCw@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CANiq72kyAx=wbvYWBTmPb4eppfvGuFsjVMa49nZBrXGbLEDiCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/20/25 13:00, Miguel Ojeda wrote:
> On Thu, Mar 20, 2025 at 11:26 AM Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>> As far as I understand, Miguel would take patch 1-5 for v6.15 and
>> modules would take patch 6-7 for v6.16. At least that is my
>> understanding from [1], @Petr and @Miguel please correct me if I am
>> wrong.
> 
> So I offered that as an option -- I assume it is OK since nobody said
> anything (please correct me if I am wrong), and it would help get
> things moving.
> 
> So I will take 1-5 later today or tomorrow unless someone shouts.

Yep, looks good to me.

-- 
Thanks,
Petr

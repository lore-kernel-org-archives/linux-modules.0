Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A25407CE3
	for <linux-modules@vger.kernel.org>; Wed, 17 Jun 2026 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702939; cv=none; b=fJWbBjA80/BI/Y7KLXGXJ+CORNbDXEGho5Z3EMzz/wG1j8ke4Z/WB6UQWXpiAUGuX0FVmEgZwdy0yYM8sceNVAlJc2QepORLVlx/SElFiE76BtkU4QMiOF+i+K6ouTxGsny11HUhBCstybZTIysPi0Sat39qa57oE2ljUgHhObU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702939; c=relaxed/simple;
	bh=DT/SfVu1raNTf+QcCPueydGtPFXgb4ImBDNRId1NFQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uk+lEWmXVIJCwOFZAXOvGWiQBiuVfHkQwiytEdAnDjCqYcuODh42VLKh2GPWtwquiZhn1lokJZrrQQoKz/+rq9B1r4gDwiBc6zPFSzkOmG6/mYH4YPEGN5gM7yYhIPugpaaYy31nJTETlrehYlhzNVElPzy3hWNBD5e4zJBZnbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jcx+M93A; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jcx+M93A"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49222b6e871so42322235e9.3
        for <linux-modules@vger.kernel.org>; Wed, 17 Jun 2026 06:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781702934; x=1782307734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=po8WtOITJfbEGYTYX/+2jWNreDSLIEwOM2fWXbXrA1w=;
        b=Jcx+M93A82+c+nWCyoqoahdZiPOi1S0QQ/Y8E53xE9dIHhlugGuU6yyIzvS7tTNCsk
         7VKNdc4hw7wzVaxHgnm/AFr65Zcyl8QWrkxv5OaO778U6lPdgHsIS371hK9B4mdz6NxV
         iA9+L7dok+y5cWsjoncftGBPqZXPnPmSFA2MXDAu9u2NFO2TQ2Ngr6rohu36yMgvrH4P
         gx/+vA6pvwWi9+hAzF0z9y+fkrfY6HKuEVHDX02rw5VxdhTSSDeq6HVqaeZP/UIH+tq4
         oSOy9QvnGdqipsavb26KodoAkGVa+uUM0Pa9Cdzp+I5z304Efa18A9oikx9Oudltkt+q
         mjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781702934; x=1782307734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=po8WtOITJfbEGYTYX/+2jWNreDSLIEwOM2fWXbXrA1w=;
        b=BV8WD6VyavigUuwG4t1XNC00RD2v08862PAKGkLjJVQvaYeuN0CdDFKAMRIdH5vXxX
         AtXPobQeMaXKQb/Oz0FguJ/Tn/UulFOjI7lXLNNLujUylYq0fPRtWoZwQ+pnX3G7Q3A+
         mjqDeBpphAXwZVVIWn68wBxFwkWnN8ckTgqM6h1/72ossP7Wczkk7e5na2Cvj3ROPl0o
         soCiKxVHURftmhmlCS9ex1ZUcQNWsZkZ8F41ogKU6PwCm/vggskd/hMQT4nMikkMWZBT
         M5s7bTP7EhrAZHTFU+pBjUTL1vzuXaLIpGx0N8XEayVK75+4c/JR4tGpbyp/x5zK+GfN
         f1Aw==
X-Forwarded-Encrypted: i=1; AFNElJ9ExsJU3uHSTLXWn3LpadTWPRNmoUwSx5pxhn+X+wqBYfRm/Z4T3jYlYAfLUv2n1fMfxL+87d7br98kTbSH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx77K/ChxFdCx67I6pj+Ej8KrFT1YRp045CB+Ekh6ZdZRUbxNUi
	L+mDD1LWfMHVzvlh+AZz6k2M/kVtNKsDeAdwXCSrlggTFxBWOLZ/Ux58
X-Gm-Gg: Acq92OFfG8v+PtrTJFmmH+Syw5XYDU7Ows6+TpSsFCzSiOmhZAFwRanWrWoXkX3vl5x
	0HnKk2SnEnoXGqIJG3XM34z8xdZ0q59MHqPiuPnXA1bA4JQa0R6JoBaXlCgR2PbNjPm2TmnONnq
	ArI+qRgeyXaewQl8XX1cGMNSdDdRpx94fD4msTIVZXl95F2Rzn2NX0zuBG8BN3QXOFkfAc1YvBy
	f4FHJKXuzkIX9asl2Aj3nOpZ/6Q/YI96e+xXWcOZfEf7Z0kCqmHaeWMgEQnrB884T0i7cZcFdXX
	TEA+oOiUGnMQ0E1RNx0OY+ZGQ75laUUKFTx0SLoqzDqf2j/75/JrX6iPG32eMDZpWRyWRYlZ/iF
	3MLJ+/5Ip4ZZE6XDSUpWJC2UwQOWxxiGcelEiGU8Ujx8ZIKEDXQTf4a58aVs2XCPwv4yoYDcQGl
	XDJ8MNyElI1RpUkLQHeNlp5XcOmklT4V2TV0U+hvtmN2mB7U43xlmW
X-Received: by 2002:a05:600c:4e54:b0:490:d32b:39d6 with SMTP id 5b1f17b1804b1-4923412f17amr53648445e9.19.1781702933455;
        Wed, 17 Jun 2026 06:28:53 -0700 (PDT)
Received: from [172.16.16.38] ([195.100.225.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4ff67sm159911185e9.6.2026.06.17.06.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 06:28:52 -0700 (PDT)
Message-ID: <6d77253b-d628-4aba-a820-13d1757698a5@gmail.com>
Date: Wed, 17 Jun 2026 15:28:51 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust: add procedural macro for declaring configfs
 attributes
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao
 <leitao@debian.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-modules@vger.kernel.org
References: <20260612-configfs-syn-v3-1-3292fbc5cc32@gmail.com>
 <CANiq72=RX5V6W+1tj0GHxZusrk5OqYbZ5-xV=wvSssrx_CWXAA@mail.gmail.com>
 <75552e2d-0bc8-40a0-b783-fba64482aea9@gmail.com>
 <CANiq72=fUuX7fF1=AQ12ahYHwW7k2i28Hkpo0TtUhwV7qeojQQ@mail.gmail.com>
Content-Language: en-US, en-AU
From: Malte Wechter <maltewechter@gmail.com>
In-Reply-To: <CANiq72=fUuX7fF1=AQ12ahYHwW7k2i28Hkpo0TtUhwV7qeojQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/17/26 11:32 AM, Miguel Ojeda wrote:
> On Wed, Jun 17, 2026 at 11:13 AM Malte Wechter <maltewechter@gmail.com> wrote:
>> As of now doc strings are not generated for private items in the macros
>> crate. I am moving the `parse_ordered_fields!` macro into
>> macros/helpers.rs but this means the doc strings are not generated for
>> the macro anymore. The `parse_ordered_fields!` macro is a larger helper
>> function, and the doc strings are relevant and helpful for macro
>> developers that wants to use it.
> If it is private, then it is what it is, don't worry about it --
> developers can still read the source code.
>
> But, yes, having a render of the private items is something I have
> wanted for a long time, but as a runtime toggle, so that it is easy to
> go from one to the other (and without having to have 2 entire copies
> of the docs).
>
> Please the entry "Private documentation (perhaps as an extension of
> the private items/fields toggle)" I have at:
>
>    https://github.com/Rust-for-Linux/linux/issues/350
>
> Upstream `rustdoc` implemented an MVP of the idea via CSS/JS in this draft PR:
>
>    https://github.com/rust-lang/rust/pull/141299
>
> If you want to help on that, then you could try it and leave some
> feedback there! :)
>
> Thanks!
>
> Cheers,
> Miguel
I will leave it as it is then.
I will try and look at it if time permits :)

Best regards,

Malte


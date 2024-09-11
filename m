Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F173518592D
	for <linux-modules@vger.kernel.org>; Wed, 11 Sep 2024 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055031; cv=none; b=dapmRPk8anRH9TpVVhtiX8YmoxmOxQpVzCDYyhVD2o0Phx/d0peSR+9tGJzqIgBqCoz+FAjNt+sa2LQx3V/OQkY+fGgNCbAl0f+LlLn39H9drKRE5WlhH+B8z1PQoRSr4Wr0E+gvI7W7nEqh/egwp62XTTJILqPAJBiWowCaLig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055031; c=relaxed/simple;
	bh=9hiabN1M+tFNIMHDE9LStpgFSYodQc7eDrfAIyTkOt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJLgmFuvU2o23VGlqnE5gXBlOBY/hHJjmDo26CizxrUXI7MACfurLnsvJ3k0w3t5HT+flbUhpuQJMZ8E7fUc3eJgZiXoW2iWKjcCRkZCI9MZtd6L3tzKQP4tfcbngDInNtbXrMs9N3PuQyWKnwR1oFeEn2qPax9qnYH/+va2lZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jb8ZBocJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jb8ZBocJ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d43657255so508920466b.0
        for <linux-modules@vger.kernel.org>; Wed, 11 Sep 2024 04:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726055028; x=1726659828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0836bPdfIiVhJZmRIpwdukfSHhRJerCCPsKDHVUH+Xo=;
        b=Jb8ZBocJ7jZyWFF5OTAhOZOcqC4RFE+/vrOVXNe9nZnnRyckUmpcX6gH+63iEWoaPn
         jv8AOOF0tW+PfpzU3ER3mDJQAFv77eaKEfhqABdlqQcy7zofOqc2eBpyJzwZ8QySxsJ5
         BeDAi9IBXE5XywostMWjEzru4y14iYalgzcZi2LK1WD9DuO+wPsHoyuRTsOV35jvDnRh
         I5jQ5a8qxpE+YsPhAL7zDWi7BWkIrM7Xq/u2GS0kMP9eMRMk2v2QrTgHv3JJxeLnpKrh
         fIV3CWDoETaj07/Z+FQBx85De44D6+7F3hMIopwEpsS0x8ug+EH8ynJE+TFFPqNZR39p
         HieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726055028; x=1726659828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0836bPdfIiVhJZmRIpwdukfSHhRJerCCPsKDHVUH+Xo=;
        b=p4q3fsHs3pgglil3c57VGP+4GrL9QgtW9cFbO86O+9XsfYbVad8dp4iqpni71CXbeN
         6ufjU1yvIcRSarTMLSJMoYRoVYW9yA2qlhxFUzCzeFKeRKVuIYbmql1gI+bqbjjcDrR9
         gtDlxF2LG98GPAOSToCN6N1BkCprd05PyyzrP2fKNnv3+t8K1PWH5v/pXTWFNILDOr1M
         WzQLZf59YWWMZ0wfTsul0VZQlbNMhc4/zEGQ7FimWEo8U1MZLLyqEozXwas/Kl0CutM0
         AhbXUSnE+KeHjhuCr5Yh95iqJ2++NzbNaKOVra48ftnhSNFNxrWlNIgI0h0GAieFWNnV
         +6VA==
X-Forwarded-Encrypted: i=1; AJvYcCU5PWdVC5b+n9kF1ef89aq7aiTFdpC74TT9972rhJ65Ngb4ZeSXDzlEWT5xMnw+VtjVYXrrhq5IwTVMTuWk@vger.kernel.org
X-Gm-Message-State: AOJu0YwBzHRa4W2N23VGt5rl9uIV4PHBPyrrB8LDUueVG8cZPg9SmEBl
	tgt6ExlhACu9XCh/qbayBLmZql5dey6MFmOy+F41KLd70VtaxnpJdKgmYewQkV4=
X-Google-Smtp-Source: AGHT+IE06+xDqkLYzGpC/L+2NLQeM/nBC/Gy5jIkoMSaoEd70RtXRRQzFeVamgQr7aHe0PKw8Wnx3w==
X-Received: by 2002:a17:907:2d0a:b0:a86:82e2:8c64 with SMTP id a640c23a62f3a-a8ffab78821mr368553266b.35.1726055027526;
        Wed, 11 Sep 2024 04:43:47 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835d97sm606731866b.4.2024.09.11.04.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 04:43:47 -0700 (PDT)
Message-ID: <599892ec-3cf5-4349-984b-7c94f2ba5687@suse.com>
Date: Wed, 11 Sep 2024 13:43:46 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/19] gendwarfksyms: Add support for reserved
 structure fields
To: Sami Tolvanen <samitolvanen@google.com>, Miroslav Benes <mbenes@suse.cz>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>,
 Petr Pavlu <petr.pavlu@suse.com>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
 Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-37-samitolvanen@google.com>
 <alpine.LSU.2.21.2408301114000.1124@pobox.suse.cz>
 <CABCJKucCWfeC0yL6Q2ZcBfef0tMd9L_gmHRJt-cUYkg_4PDtnA@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CABCJKucCWfeC0yL6Q2ZcBfef0tMd9L_gmHRJt-cUYkg_4PDtnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/31/24 02:05, Sami Tolvanen wrote:
> On Fri, Aug 30, 2024 at 9:34 AM Miroslav Benes <mbenes@suse.cz> wrote:
>>
>> yes, this is one of the approaches we use in SLES. We add kabi paddings
>> to some structures in advance (see [1] as a random example) and then use
>> it later if needed.
>>
>> It is not the only approach. Much more often we do not have a padding and
>> use alignment holes ([5]), addition of a new member to the end of a
>> structure ([2] or [3]) and such "tricks" ([4] for a newly fully defined
>> structure).
> 
> Thanks for bringing this up! Sounds like we're also going to need a
> way to completely exclude specific fields from the output then. I
> think we can use a similar union approach, but instead of instructing
> the tool to use another type, we can just indicate that the field
> should be skipped. I'll come up with a solution for v3.

It might have been mentioned previously, not sure, but one more case to
consider is handling of enum declarations. New enumerators can be
typically added without breaking ABI, e.g. 'enum E { OLD1, OLD2, NEW }'.
It would be then great to have some ability to hide them from
gendwarfksyms.

I think neither of the __kabi_reserved or __gendwarfksyms_declonly
mechanism can currently help with that.

-- 
Thanks,
Petr

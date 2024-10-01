Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A223D1C9DF2
	for <linux-modules@vger.kernel.org>; Tue,  1 Oct 2024 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791966; cv=none; b=vBjr8CJNCXUlbkR1NQVC3wfLDTGsnULkW0eaaLhKeJlZZEz5r38n2edyK3M2Zmx8oTq2qnVsAQvKrgv27vH9KYOeCnPUHBsUHdJxaf6Gjk9juYXELK1AJiNF77Abl36LiM+Nhsz6Oyw9h7hx8ONFwAMcsp/tG/WrQNcoH2MNDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791966; c=relaxed/simple;
	bh=zANKrDNHHPw85OVvoKNOqJRMnnY/7KTHaVV++XWrNQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjnMV/pA00Vp9rMmaE2ghHbKJByc01qTydfVmAseS81yw5iyuikzDnIEYfvo/1heOHM+VokvFmRjIfZ8AiS5NxuqJWmwZIyZeoxw12p8XGXNhFsRjhh9BxBj/+w/nKdZ/Nvawva2dAdvOrIhg23ISxUG1rp5WtQHJI4DGw6fXNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QWgh4C2D; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QWgh4C2D"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso848188566b.3
        for <linux-modules@vger.kernel.org>; Tue, 01 Oct 2024 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727791963; x=1728396763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DeoJTd250N86AwxT75TCft/ULiYvSUL27Dnc1hyjfJ8=;
        b=QWgh4C2DrgxG8VEkHG3EXtLpEVkP/ikONr6tZRKUxt38gI32nCdElG+xv/7OksKHVa
         jZHaw4WF7d0GXOJSP38L4e68jy5aqzHBX/r6BLSOYLKmlQhFfXe25Ko94c9EF9BcwWGh
         lXk94Tg59hzUdyee2pNLbYRSTA+5378t3VnFZP+Aap2jpuyXmZCrO10nVXiEoBLaTG+w
         Y+zSsgtXt5vihZiBpH95aXtUH0FUxiTVl1psEPBQ56Sl4ERo45HpDPp+z7fk5c2qOkug
         NqJGpyS4FkEgtQdZ6fpojR8qEqJ5dKMhUcKhyXOk/DcsTt80K/gPAiMmXwTZZ+2JYEI0
         nDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727791963; x=1728396763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DeoJTd250N86AwxT75TCft/ULiYvSUL27Dnc1hyjfJ8=;
        b=QuEfYceOtchQ9U6QTxXhB/SmVMJ4neH0wmA/odi3rE3B030VqKxlEWyZ1j/MRHW8Ex
         m8sIhW6A/9QiktHQkTzc/K36dsUFxN//ugyh/jMHgsxQekob2Muv56VFrIS2SCU0j2tA
         iltkp1KQW4thH+zYHpL48fl8gjtaz8JdY3Yce5AbmTJE12sAmbXJJMcusflH6V45MfLM
         +1MH5ms+0Ydc2mXJJHVjF9Jnqs5uWALqw0QZ4bJ3Mv4YgNa3ErrTxCGVsSiUVRpq/6Ew
         i8K7O3sC+p+3oRTxeFZcnC/n2TvphcLQE6vEwHNjb8KyGfY6ReaL7ZMGepNbFwX/2F2Z
         s9kg==
X-Forwarded-Encrypted: i=1; AJvYcCXV/dJIIj5V3Ee/bmdgJHDkKD27DUT+XGAtb73laPLYVt2PcHf6zjuo3RSUX5l3MLw/3UmbbZBNKXy7hcbh@vger.kernel.org
X-Gm-Message-State: AOJu0YxrivT6j+TCVAZ8Oz1JJUmmeKiY2glTO5koFCsY6chFR+Y5vBgS
	bqMYWrWxRThriqv6SOyNAnR4XFLNL1XgUA48EuHkDkqGtN2kaEd78FnfWqNXD90=
X-Google-Smtp-Source: AGHT+IFkBtWi40iUpXvMtDXyvuH4imak9CnOFIL9Jv+C/N0N1k9h3hOedmoIkMwXqfp0vxX1k3WfwA==
X-Received: by 2002:a17:907:d20:b0:a86:82e2:8c6d with SMTP id a640c23a62f3a-a93c4aefc0cmr1881927566b.62.1727791962932;
        Tue, 01 Oct 2024 07:12:42 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c5af5sm717179766b.70.2024.10.01.07.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:12:42 -0700 (PDT)
Message-ID: <105dd859-f018-4b24-96f0-f395d53db9b9@suse.com>
Date: Tue, 1 Oct 2024 16:12:41 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/20] gendwarfksyms: Expand subroutine_type
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>,
 Petr Pavlu <petr.pavlu@suse.com>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
 Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20240923181846.549877-22-samitolvanen@google.com>
 <20240923181846.549877-30-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20240923181846.549877-30-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/24 20:18, Sami Tolvanen wrote:
> Add support for expanding DW_TAG_subroutine_type and the parameters
> in DW_TAG_formal_parameter. Use this to also expand subprograms.
> 
> Example output with --dump-dies:
> 
>   subprogram (
>     formal_parameter pointer_type {
>       const_type {
>         base_type char byte_size(1) encoding(6)
>       }
>     }
>   )
>   -> base_type unsigned long byte_size(8) encoding(7)
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> [...]

Looks ok to me, feel free to add:
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

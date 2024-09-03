Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88971188A1A
	for <linux-modules@vger.kernel.org>; Tue,  3 Sep 2024 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376541; cv=none; b=u/7LpY3tyMxngRlJmn5vOH8PR/6AnbBs2yr23rX0K1BW0UD24Obqlpa3XaSJmDa/NUAIajWOEOePwdq53JxY3JlntAVw/EfylGXbNfmdo3m41OWdPy3F8ZYuJ8AditLgiV4TBmdzjqlY88+6xZ9/sFoQUYSovpEpnvdwaOI9vAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376541; c=relaxed/simple;
	bh=VQoch2Jnk1OtZ5AtE+c96J0cQy86KkHUvIBG+sr4F1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecgm5sZZ6LCIAouOFmFlfMHdKKn194cxeaoeQJEml33MAzfTO9bQf9jFsdLfXeDbsKzGB5kHisvv/I0tjpra4JSlzNgxiFv8ziaEsDxFEykejMU+YLr+TnThIDHnJ68Q+pzFhwgnx5uqwloyodK68BmVqe87ZJPK6TfXmvcUhNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WULXNsMF; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WULXNsMF"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-533496017f8so7351158e87.0
        for <linux-modules@vger.kernel.org>; Tue, 03 Sep 2024 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725376538; x=1725981338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+e0U/aRCvU8DuFYoeV8O/KmFptz8b7Txjch+YXTIjA=;
        b=WULXNsMFwBairxyGwUrNlaDT+LuyCLt4ia6PJNtRKhbDZfTcfO8L3m2HiHfk3cDrX7
         +DjCPhtyfHVECGC0+DkgAMq75e6ZgJXAlNykaS7KVzBehf/tZG5cxmGlLA30bq4eSUgF
         MgHMXRUKF8QNAzHAtaLKW1/qrv8VJqnzzzGalq8BxhYWfHG+ESNn7ZnYme/vPuZJ6VQr
         f6ALrlWHrQa9RXeo/Rm6s771mFMl0Q9y/rO9Y59ZJ6JgQ3KU8Lu6UwBjZzr/C2NF9nbR
         jEDJxh/RVmMCTO1Y8hYk6mqebkmxZ5q5LHveKKI9pTBo+MkrefIpG2WH7AGnZWnkcDv/
         bZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376538; x=1725981338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+e0U/aRCvU8DuFYoeV8O/KmFptz8b7Txjch+YXTIjA=;
        b=SYrXH19/9R0ZNxTqtpVwyU7gACmsiU/ttbDxk8UMG7508MhAzwT0OLJiVqEC5U/LAX
         uyaIz71cfoApUxb7AH0XJ7+sgH/Kj29wUqXi5zLBnrb6LiDUulprjskyTCw0ffowkWqA
         8cKp3vxgFrauq/R2cTLk2WyuzMPUSW9FbXb2hE5+TI1W0xq2KrjWREMnjFV4GvhG9aXP
         sW0ijX40Nr5jR4G75EliRWeukhQBywoiKNO1iIlcYAuJoI9ukhrq/TIT7oTha3IPvL6I
         wqbvEqbt1GLIYwm51DCcdSCKWZQRXIxN4GdnLQBtNF5YhbzrAVNBzvFqSmo6Kxct/Ddk
         rpgA==
X-Forwarded-Encrypted: i=1; AJvYcCW9qlYgNPEj6r3MLxibiaGQXtjZmmubk+3eQ9i7pqeSQn9B5E8PO35emSRgnN4LiU/I87pP8uOImgHrZysU@vger.kernel.org
X-Gm-Message-State: AOJu0YwnrfTcW00EKUfDgBd/4mgB3aLsfNMsinY3nr7ytgeapcx7Kvlj
	Bh4NJ8Kc8h2VG5yGuv1ITPCgBG1l+yOMIB4O+fE8qXkpxHjDbF2hj3FilXineFw=
X-Google-Smtp-Source: AGHT+IGdZTw/KUyMiDlZSkuc9mANPu7vBYcf24gYwin1fZw518o/l8XDosnXT/1xrZtFfnHMtfr7sg==
X-Received: by 2002:a05:6512:2383:b0:52c:9468:c991 with SMTP id 2adb3069b0e04-53546b03ffamr9361946e87.14.1725376537413;
        Tue, 03 Sep 2024 08:15:37 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a2fdsm6520881a12.13.2024.09.03.08.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 08:15:37 -0700 (PDT)
Message-ID: <47bc562d-b9c7-464b-a2e2-dbb8c14d146b@suse.com>
Date: Tue, 3 Sep 2024 17:15:36 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/19] gendwarfksyms: Limit structure expansion
To: Sami Tolvanen <samitolvanen@google.com>
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
 <20240815173903.4172139-32-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20240815173903.4172139-32-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/24 19:39, Sami Tolvanen wrote:
> Expand each structure type only once per exported symbol. This
> is necessary to support self-referential structures, which would
> otherwise result in infinite recursion, but is still sufficient for
> catching ABI changes.
> 
> For pointers to structure types, limit type expansion inside the
> pointer to two levels. This should be plenty for detecting ABI
> differences, but it stops us from pulling in half the kernel for
> types that contain pointers to large kernel data structures, like
> task_struct, for example.

I'm quite worried about this optimization for pointer types. It could
result in some kABI changes not being recognized.

I assume the goal of the optimization is to speed up the tool's runtime.
How much does it improve the processing time and is there any other way
how it could be done?

> diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
> index 92b6ca4c5c91..2f1601015c4e 100644
> --- a/scripts/gendwarfksyms/dwarf.c
> +++ b/scripts/gendwarfksyms/dwarf.c
> [...]
> @@ -651,6 +742,7 @@ static int process_exported_symbols(struct state *state, struct die *cache,
>  		else
>  			check(process_variable(state, &state->die));
>  
> +		cache_clear_expanded(&state->expansion_cache);
>  		return 0;
>  	default:
>  		return 0;

I wonder if it would make sense to share the cache between processing
individual exported symbols.

The hard case looks to be the following:
s#A struct A { int ; }
s#B struct B { s#A ; }
foo void foo ( s#B )
bar void bar ( s#A , s#B )

When processing foo, the code would cache s#B with expanded s#A.
However, when processing bar and reaching s#B, the cache should report
a miss because s#B with unexpanded s#A is required.

So the code would need to track which types were already expanded and
have each cache entry accordingly tagged with similar data.

Hm, it might be that doing all this additional tracking would then be
actually slower than processing the types repeatedly for each symbol.
I'm not sure.

-- 
Thanks,
Petr

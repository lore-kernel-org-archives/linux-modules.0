Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C1D1C3C08;
	Tue, 26 Aug 2025 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201869; cv=none; b=rsAYUM6ySLLhNDsIIZXpmMMW9Ssvfz40MAXxCmqg50Xdakwv6+8V0LFLGKkuBE7xQLRMuOWzUaGald5vURwmGT1tE1lbQLsXS3joZsMAVSU5kdCq+/8/kPILKCuBr60A7Ik7fzb4W8jIoo5TQaVMdOpKeE36BtxboZVZvBKNUn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201869; c=relaxed/simple;
	bh=CwVr4RX8gbDe4qxlAAE1okF7Zn+dquLwYFmpDG6+/MI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wd3O6HFAPT+0K+l/CV2yOLu+zdnzioZKqntp6QARWRxkNcbDxKQI6Xcz+gixwqG3Re3Ygl8Vxr6g+056Deh6id+uTsCKU3uD7NxgSWVtbCLBgHIRzKwptoqcfyNf3RODg6maSEg9eW7J46HdMzjMUVjcgaIFfdl6pInRGiDzvQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3r9qy+M; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3r9qy+M"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b475dfb4f42so3653509a12.0;
        Tue, 26 Aug 2025 02:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756201867; x=1756806667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S+oUJPTWB8DlIO9yqYlcDMK+AvxbsTryDTMCee8+s38=;
        b=Y3r9qy+MY6Qabi5XqOWWGQYjERnFsE34Dm0wyBYxMgSi5Abq2r2Ch0MwKQ6kq7kZKr
         XIdI1G3kyKWByNVQsqOzmOY1E1vLktPg8B4nfcSExBFNF0TCNun9ogxcvUCJ66xqDz8P
         bYK0nzPqFiUDpGsoSAm2uR7dZ7L9u3kjNG+Jdr8nhyNZHLgAbQJn2uilD1DyxA0Ig+2L
         /5tg1CuE1SKap1ZO696EQYU2uanTNVJJ18n9D/de7XyW4S+a4gFV6vgnysmVm3d8pR4d
         WCDkj940f9ya3Q3vsp1vFCdN5KL85WsDfvMYkpcE/vHZtKXKfngvj4m7GstgvXLcAT3k
         nDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756201867; x=1756806667;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+oUJPTWB8DlIO9yqYlcDMK+AvxbsTryDTMCee8+s38=;
        b=k9uf7m32NDdrBMZYLN2KOL30T7nN03h6VTpF01VWp8OPH0srx2YOXspif8V5Gp0RpV
         n1o1nfr86vKYlRVUevNtGpF6ieznOro7unHUvNteeHbmVzBV7WkODgZnhqRLV0ud56mw
         Z330u4mYLkIVy/HLhE18GrKtqj46I54t8kEafxHJezMZ9j+5yMcLTkipnOT1kKd1v+Y4
         JoATWTFXZsrPZH+A6rTlNWRVrM2+63UTszlsXyHK4TA+RuNblF6duBiPeL2Z0pYNJH7J
         BSVX/as58Rsqr6sVbTEVvTDANsfdSG6O8AKHMvWqVYGodgwltIv/6GFHNSt1t8/n8kUy
         v+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP0c1A07tyNHwd6UjA6uvmYddyZhZ+bieu8qgyNxZaKYo/ZBvo6KlxJKzCNC62OkWlIO/f+B8Ees+rpbk=@vger.kernel.org, AJvYcCXY5KabAuH8enB5DobVYjY5ebsirmP577UGpsYwsb4drQWpRPzdp7UaUBloMhCN6o+8oiJraAultNbmugwYWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4zfR1Zpw3zDsxqojRXnEfN+rXHsOBDT0x1RvXMBHFVqC+4ixh
	ofi6pwpFMXuWk3MeTQ2mssBPOUH+08xfwgPLobwLRdANFEvogV58OFBz
X-Gm-Gg: ASbGncs+7AbpRlf2A+URW9dMHuZG/GdTlbSFrvw2EwjuNReiEBg8/w5VnUIParZe7il
	uA+BnvreK+yil0eXvcqqMySH/IgC+1zJJb6tYGEv3d6J90iTOelsxagJBRrbRiTgDx6d46JZrDB
	+u1ScMBioYC7wtz4EbVKYC+ktwwgPD3sVi7fLRhY3F512osu6Sff6jawcDvmge2VMSz42LvjL5c
	AInTGQ1oWaYpwOZOhYWwuPRh+9SLn+y6HetfZJUKddEkdq+4zmJOQ5wyn5irPbabedG91jl4ZXX
	lWC5GnFos/B7C3fJwHLttg6eumDg0BHvMsGkAM4Rrivrow71CFBsZtkIJPvQ5ik35NmvPizeg2j
	XElD8yU3TSDRG7wD8EBs26PRbXvCdgTOLvceirzh1OYsKY6F07L9pfZf0tVY=
X-Google-Smtp-Source: AGHT+IEsnB9h8HQbTQ2V93YwU7fvO4wdZ9OH5V36EUwye/rm2G7duDx03V2i+6SWxNvsg4hh+tZfcw==
X-Received: by 2002:a17:902:dad0:b0:248:79d4:93aa with SMTP id d9443c01a7336-24879d497bemr8362515ad.53.1756201867212;
        Tue, 26 Aug 2025 02:51:07 -0700 (PDT)
Received: from [127.0.0.1] ([103.88.46.127])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c04c7522fsm4900440a12.5.2025.08.26.02.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:51:06 -0700 (PDT)
Message-ID: <3b96de64-166c-4e96-99e4-714310e13d52@gmail.com>
Date: Tue, 26 Aug 2025 17:51:01 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jinchao Wang <wangjinchao600@gmail.com>
Subject: Re: [PATCH v2 2/4] module: show why force load fails
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250825091545.18607-1-wangjinchao600@gmail.com>
 <20250825091545.18607-3-wangjinchao600@gmail.com>
 <52288605-a16c-4a93-9e80-66d32de88847@suse.com>
Content-Language: en-US
In-Reply-To: <52288605-a16c-4a93-9e80-66d32de88847@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/25 17:33, Petr Pavlu wrote:
> On 8/25/25 11:15 AM, Jinchao Wang wrote:
>> Include reason in error message when force loading is disabled.
>>
>> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
>> ---
>>   kernel/module/main.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index c66b26184936..a426bd8a18b5 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -1083,6 +1083,7 @@ int try_to_force_load(struct module *mod, const char *reason)
>>   	add_taint_module(mod, TAINT_FORCED_MODULE, LOCKDEP_NOW_UNRELIABLE);
>>   	return 0;
>>   #else
>> +	pr_err("%s force load is not supported\n", reason);
>>   	return -ENOEXEC;
>>   #endif
>>   }
> 
> The module name is already available at all points where
> try_to_force_load() is called, so the new error message should include
> it.
> 
> Additionally, we should be careful about the message. In the case of the
> init_module syscall, the missing modversions and vermagic could mean
> that the data was deliberately stripped by kmod because the module was
> inserted with --force, or it could mean that the module lacks this data
> in the first place. In other words, it is not always the case that that
> we're reaching this logic because of a force load.
> 
> My suggestion would be to use the following:
> 
> pr_err("%s: %s, force load is not supported\n", mod->name, reason);
> 
Good suggestion. Thanks.

-- 
Best regards,
Jinchao

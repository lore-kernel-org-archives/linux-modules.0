Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471B9312806
	for <linux-modules@vger.kernel.org>; Thu, 22 Jan 2026 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070866; cv=none; b=tlVH7DlzCiJI4T3I+IcQ9RvyJGnBRKCYOIClqkV3yjvKWP9cjePcNAyiWLqBKdQr3jO+VQ9gR/YnzFXMp1XQrGKRrOZ6KwJ9GjaHC7SP7ewVFS4MfYKX2Dbe25dQwt0jpbVNnpHzZ5nFc40g3Kc6sx5QI47Wbc9gkAnx2Ra8JWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070866; c=relaxed/simple;
	bh=HDmT7452O0N3cmGqBBG5WAgmjA1jG55LJF5kcmV7B/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=py6Re3f2afA0gWVcNDsM1h51mUx/u6mC0qdMg2+iOZB0UpdWn/p5co5DnbGeVjvd4XHcq7cmFp0FT/f4LDKqqc2H8DmTmoXp+qrtrJR+zwtJIMiV0LGNLa9GYq6rgBbGkB7hLrwGzovZy6hpRj7NWpgaEHVpS8IbpyNYRmF4l/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aavlEQUN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aavlEQUN"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ee07570deso5389105e9.1
        for <linux-modules@vger.kernel.org>; Thu, 22 Jan 2026 00:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769070862; x=1769675662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=unjwSicxh/p6Pdh6zOxk+15CQX9Jqpe/B74PqYozyAs=;
        b=aavlEQUN+kSrGW/kzvOwhIeIv4z3WVQxtDSwPSnKtiQhsXuHfGLSISQUs2aszEVLkx
         zkldq0LW0Lc4Sj0agmEy6ViSfML9ZrFl5vcD0aRCkqtHQI60IcBC07t9ArN/+PucvEsJ
         J49/czabYtRy+6Emed2/EYyFEBdnGQEFO4gHOmCpo9IE2B8azV+zJZP8liI/0Std97x1
         LMwbKYHtEsfU25MNVc/N/zBcxHr5LY5IrFGlrJe/bgu45dY0n0MiF4trVzkmfp+1wACf
         +DyV997E/e60Qhnk324b6ZogRC5xZkwJAD2HTN+2EJgfTONR83du1yOsmg/zOHPHtYFn
         fJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769070862; x=1769675662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unjwSicxh/p6Pdh6zOxk+15CQX9Jqpe/B74PqYozyAs=;
        b=oMjMLJ7GkKC3rOtF3x9gbm9+Dia7mXvYcT52PoabkFYr8b4WhPeWNpaG+f6O3gVccn
         YKq9CHSZTNf/UXZ97Z/VO1Aox9fo4iC/dsJnIo5owPSFOR87JA60uhGH4jEgMg0JRl6N
         0XmavKxltJioXxHla8WlvSYXw83yhhhy/+Msi6VIpgb73p18QR0RWZ98yssps1QemPIl
         stxFzXdbWHXCPJqJEcejDol8Rh1k/dKNqTr5beBekei+TNpDFHHuiygxheRy5VBNEYWy
         FSK3eNIafKqOfzjtwOWO851ssAIabE43f4/UJRM3SGr41NmmZGP+oWN/f3ZEKIsAabEm
         p9Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWMuwQnYid+Zj34/oQmymQ2GGWemuetFKxVw8WST3nlJkiE5Rx29pvH6igI7rkm/eAW6fNB/HJbyWX7YPQo@vger.kernel.org
X-Gm-Message-State: AOJu0YwsVQltXBKjoZ3EA6SMmpf+hvQXMMc4CNLSuVm4D4+XOsmR8PyW
	6efW5L3V/79uFBkfFea8+90ixjXMLaao4lOk49xmdlGQNIxK/pc8UeuLmMoC+G0NbfI=
X-Gm-Gg: AZuq6aKWX+zd45ZZijZ/sxht9D/lwPsSYmjz8/MOPHgxbXmvdfbR/GszHXTbDCGUfuP
	0awuhfujEvrVQnxWJz1zZrEd4QHvh+XSy6TXvdKcbRb92a/yP38dax+aRIdTIoFglzChUxoz+8b
	D94NjCgU4JSXDYQUv8iGDC0qsbxgKA2WpO2/RTnVoNMEveK3oVDW7yYJ1eBIm6v61NiQx7kFP8K
	T9doiXpbwYYwG+z7OeiuveVpOiaAb1l9YFkkF9iMR/uEP+GTDV6T71OG1QPMbFFhlzYKUeqk9OF
	Vujg53qwiEeFaMCuIYOp+yeAGl4fSUrVEezVOMFjRGbCSLewvSIOoGpsgCz/NZP4A7cq7V1LQFM
	GQqlSnY0P47Ys+8p+fvkTy0vTH1yfsTatieoq5rYVcbDQ/SfDDmFc3hBRJ64PWoR6kAXMzpUxk3
	6XCzCeziQSQWemIgaUdbmuYE1di+R9yRaTpV8O2LqvFpPnIaUJLO31YaVzL+LpgZohcRznMRwJg
	GX0kTAW83N1PxBOEFwnOv3y6cnHhFCbg+uRNH40VvjxVYQolojkF8kgQsHCXzgjC0wYB9UE7ucf
	qLY=
X-Received: by 2002:a05:600c:8285:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-4801eac3169mr237845285e9.11.1769070862531;
        Thu, 22 Jan 2026 00:34:22 -0800 (PST)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804244c6cesm50432815e9.0.2026.01.22.00.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 00:34:22 -0800 (PST)
Message-ID: <30b09639-42e3-48f5-8e7a-12d2589f20e4@suse.com>
Date: Thu, 22 Jan 2026 09:34:20 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] livepatch: Fix having __klp_objects relics in
 non-livepatch modules
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Peter Zijlstra <peterz@infradead.org>, live-patching@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260121082842.3050453-1-petr.pavlu@suse.com>
 <20260121082842.3050453-2-petr.pavlu@suse.com>
 <okmrns5zlxqkwrou5rspq3zyakuv4gwwe4do7yovjbeaa5eajh@fud5amphpycu>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <okmrns5zlxqkwrou5rspq3zyakuv4gwwe4do7yovjbeaa5eajh@fud5amphpycu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/21/26 10:04 PM, Josh Poimboeuf wrote:
> On Wed, Jan 21, 2026 at 09:28:16AM +0100, Petr Pavlu wrote:
>> +void *klp_locate_section_objs(const struct module *mod, const char *name,
>> +			      size_t object_size, unsigned int *nr_objs)
>> +{
>> +	struct klp_modinfo *info = mod->klp_info;
>> +
>> +	for (int i = 1; i < info->hdr.e_shnum; i++) {
>> +		Elf_Shdr *shdr = &info->sechdrs[i];
>> +
>> +		if (strcmp(info->secstrings + shdr->sh_name, name))
>> +			continue;
>> +
>> +		*nr_objs = shdr->sh_size / object_size;
>> +		return (void *)shdr->sh_addr;
>> +	}
>> +
>> +	*nr_objs = 0;
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(klp_locate_section_objs);
> 
> How about we make it even more generic with something like
> 
> void *klp_find_section_by_name(const struct module *mod, const char *name,
> 			       size_t *sec_size);
> 
> ?
> 
> I think that would help the code read more clearly.
Ok, I'll update it.

-- 
Thanks,
Petr

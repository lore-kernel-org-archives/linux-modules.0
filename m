Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534052BF01D
	for <linux-modules@vger.kernel.org>; Mon, 16 Jun 2025 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082293; cv=none; b=MdWUGOTea6CzvRxuj4AvemAO0MUbMR0AFnBzSuJshrnVHbe7ooVnqhLQMLT16pX043eGk7soS0TeABNHDuIwz8ZnVBj8p1D7A9Uga8GjnXXptXXxcGqve1IfMOlKzhhNe47HQ7AvXm5tXEuWxlHxhMYVWf3SCruXjt0JuiOPfYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082293; c=relaxed/simple;
	bh=eNe1aGesW57V06u9+X7qSzUwlvkFL+QPjXfzqELIBUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=El25sya4Wt3m8po66HBYVGsqD9HzZgDiT848wN1HHhnfp8xYKbsHX4Hjyp6ZhcKg/ibOVAnaWfdyv0lLlp56RexETFJ1DZMGYyUxldK3idwzvZIJ1h+hFKYbKkxABH2ULEQdpG1xQt/00gZOapxsiLCctFVAh7pKA2LvySLqeHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lxhe8rCt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lxhe8rCt"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso40563715e9.2
        for <linux-modules@vger.kernel.org>; Mon, 16 Jun 2025 06:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750082290; x=1750687090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVgzfdytw7GLqgjKncwxWa9YLoT5JIIwN29MSREtEbI=;
        b=Lxhe8rCt9rVIQ7W+kwcUFZgvMT7VK47pwX6ygdkCLhFPYVijHBeNowf1PdMYU4jy7s
         dkAMmeal1EtepNeKPR8zP8rU516G3sEhVNZjUbQUSqDlvA68BdcUEZHI7VAsRQfII2CA
         8UoqIUfSGaeVblbC4DX6LLrQXkngMWd6tnlufQwrkqp7Z882/l/ysQ6ik+FJKxyRTDbO
         1bkiB5ENtjy38AWSOujHuScXahq4xwzEOS0HS/PO+UDKNYJL+OyE4fO4aqCjN4evZEX5
         JwgSYiykp2xcFbsop9GC5isOOa/RLYq9oiHUQ4cgisiw2SA6QodAfiVYkqK+bwX+HtOI
         Zq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082290; x=1750687090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVgzfdytw7GLqgjKncwxWa9YLoT5JIIwN29MSREtEbI=;
        b=p7+W+gdKJzqz4pYlxi8SS4urkvhVKGACC1faLMLNRAAm66Mm51ziCvjr/P1k9z5pXZ
         /9+k/ASXnkGHN0zFycTZtQqebjb8ks31yhlORNjY4g/DmyR1aKKQ/vhBxiWaTsffehuO
         JLlQ9zGH+Dt53aHUshWYWsMZ7WUva3B/S+PpE4/57RcirAw3hmybPIJe+gSV22UelbS/
         GOY3ggKWHDMVulVBQAwvIZeFAMqe8kIzEOT5E3/xeUPhLP7ONrXXHWpib7PVyIEUu3io
         ECH7dNlOI58b2azIZ6WoETNfXh6bnx0UjgBcY4WKcXhhq7mgRvtUo5o6XO3UussA1dgQ
         8N0g==
X-Forwarded-Encrypted: i=1; AJvYcCVzOcl3l6ZBk2HmiueQ4Q1isr5JY420jsgLiD0RNP36cp2oOrfbBR+o6QcF53IepZNoHLBM02RsqDTL+FCR@vger.kernel.org
X-Gm-Message-State: AOJu0YzCPaXntzriaQtXX8StlpfzhtrezIENq5Jps0DRuFxhhAtAzeAO
	AKeAhZp2jjPI6AHxtbl1MSYG4vITbbcUXZI3EfsFZAnD1foKsU0Q8lQHdga8blWYk9M=
X-Gm-Gg: ASbGncvFADmeuF8Uw5XLwjLj94jMQNOp89FBDIbJoiR/RWL+YKC3IXAEECOtMY70Q1q
	ETo8ABfp2oD2LtP/elalhGlovi8NkT7FqxlZb5qupk9EczIkal9GT+M4rkeQDpqOtwsNPhI3B+Z
	NbrAKQST3bpiieaE8DTde4VYXZcchp4R3ed+EdGMKF4F8OX/pG4uSx6waKBI234+TwLr2ZAC2ka
	2rrjI1Z1+kIShtTRn5ecwMml6fkqWvwvfycs5PPEweTgWPXyH6BeZ8I7OXw7EMrGtwhlHyhspDr
	q7Lljl89mJrfvxiAY6ZiIN9TW6Mt33rfCt6uuNnx7+cNGEYFjaiYM6+usUN9SuI4MQ==
X-Google-Smtp-Source: AGHT+IHTrudFH8bOP+1JEl3Xxm/O1MDRV2TH0s4tp7P/yBD7QShr6ZwCmRNFJoYZdJnnkRQ7CUzYWA==
X-Received: by 2002:a05:600c:46cb:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-4533ca5f35emr90530715e9.4.1750082289684;
        Mon, 16 Jun 2025 06:58:09 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e261ebdsm151289895e9.39.2025.06.16.06.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 06:58:09 -0700 (PDT)
Message-ID: <97f26140-bf53-4c4d-bf63-2dd353a3ec85@suse.com>
Date: Mon, 16 Jun 2025 15:58:09 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] module: Fix memory deallocation on error path in
 move_module()
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250607161823.409691-1-petr.pavlu@suse.com>
 <20250607161823.409691-2-petr.pavlu@suse.com>
 <ae967353-71fa-4438-a84b-8f7e2815f485@kernel.org>
 <c7dbb33d-98b6-45da-be77-e86b9e6787ee@suse.com>
 <7cf40cd1-fe0d-4493-ac15-e70c418e54a5@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <7cf40cd1-fe0d-4493-ac15-e70c418e54a5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/14/25 11:28 PM, Daniel Gomez wrote:
>> This seems to be off by one. For instance, if the loop reaches the last
>> valid type in mod_mem_type, MOD_INIT_RODATA, and successfully allocates
>> its memory, the variable t gets set to MOD_INIT_RODATA. Subsequently, if
>> an error occurs later in move_module() and control is transferred to
>> out_err, the deallocation starts from t-1, and therefore MOD_INIT_RODATA
>> doesn't get freed.
>>
>> If we want to always start from the last type found, the code would need
>> to be:
>>
>> 		[...]
>> 		ret = module_memory_alloc(mod, type);
>> 		if (ret)
>> 			goto out_err;
>> 		t = type + 1;
>> 	}
>>
>> I can adjust it in this way if it is preferred.
>>
> 
> My earlier suggestion was incorrect. We can simply initialize the memory
> type t to MOD_MEM_NUM_TYPES since it's only used in the error path of
> module_memory_alloc().

Do you mean the following, or something else:

static int move_module(struct module *mod, struct load_info *info)
{
	int i;
	enum mod_mem_type t = MOD_MEM_NUM_TYPES;
	int ret;
	bool codetag_section_found = false;

	for_each_mod_mem_type(type) {
		if (!mod->mem[type].size) {
			mod->mem[type].base = NULL;
			continue;
		}

		ret = module_memory_alloc(mod, type);
		if (ret) {
			t = type;
			goto out_err;
		}
	}

	[...]
}

-- 
Thanks,
Petr

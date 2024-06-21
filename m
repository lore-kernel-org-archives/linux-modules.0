Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D4E1C6AE;
	Fri, 21 Jun 2024 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718978733; cv=none; b=YgzctA+tFzyyG7SlxinYnfCe57uTvQBmwq6sCEcBAs4mt8AeeeJzaDWdf9I5d+RCwBIgcI80pi0kPrgoOC6pOIZ7KsRjwawJdSmAEuo7a8b5feUfeNsuyffT8nTQJWsPRrQl0mkoBudLa3Xm9Ub0qcb8Jbje/qEmLLST/mch3F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718978733; c=relaxed/simple;
	bh=yuotip3A++Imju9TIlRyWIX9Hz12rjq9v0ORXMClkKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/8ogMu0e01Ag3+Zj62HLYeMyaByCQfoPU7IXY/h4NSGHOm61AornHjxQ2TNcvFBR8U6q+Zl05QHRTfERKdVdiZ0+jN8jYHFRSeNjz8EKSkonwy3eQMJqQyF7sHcndYiRXVuH10/zmHHCu6+e8+Si2a1FWWpjHHvs2zAXTURcnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ6AH7lO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ6AH7lO"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57d1594f3a6so281436a12.2;
        Fri, 21 Jun 2024 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718978729; x=1719583529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40HbaQmw1uqMcmJEzd00zU+aYd8S4BfIEJlv4tjDiw4=;
        b=gQ6AH7lOCX9oVg/waIum1fg626Bbfy0LH7KwwiWzcwshBYgT7nF8gIuLR+/JVm0MDP
         CgaIdfBJ6xltMDIkDfx7uDjaAdnaun3RZCQLw9nN17j5fA3jGTG21hzbgRpG6gMLY9IP
         U6one6K/pGdEcjfSehJsYe9wAQZPs+EynkeMYTFcYqof2kXBkmyl04uAnYS0cmKWvUHt
         zp3vRr860RJhihAGxafjMjDMV9fFFnGAU35W2WqYVWYAHLlnXL2/U6OBhe3EY0LMs0qI
         A7tDrwkaYAbqFNcLwO8jBW77cHKmMnX/v+gKpeN0rFTUfVSi7VR2vdY9DO1ZTnaocK/k
         0dOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718978729; x=1719583529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=40HbaQmw1uqMcmJEzd00zU+aYd8S4BfIEJlv4tjDiw4=;
        b=CJzAZR7Q6RYB2qryxiEoorU2snJVojdxYZEtO6OARiN2yqFx0ytMA27uO1dltf/0ml
         Z+RTCKeU6Cy4+aK9Y9+HT3+DP1YSzlG/5FRneP7EzzQdWJrY8+x4d+bpVlRqEHta6BWP
         WZGdgkjvUozR3aqluRSINyBn1dBxaEVL5xVcSc1KK+FmUPjRRBlqRIybNEsB37Ln7NG6
         g/iagJhqkI820AvxIt6GGw9uaktjuMCo5AibURfvPJLkBqWeUtlh5dDK/iyBzbLBdkwm
         uq5GEKcWmkBFk5fYju4WH7azt4AEnSuH9sAHRBDsdhM4yfqvLy9uUrfs9rQa2wwGwkAd
         WPog==
X-Forwarded-Encrypted: i=1; AJvYcCXr7GhIJ0rAcjsU/Yz+dHhz2TkYacxFNW1cLIAdxZdXaM9q847QpXkyQdYYE5iN6cGKHZnaO0bM43lfoZXdcoSWmSn/v/KhqZ4fkh0r
X-Gm-Message-State: AOJu0YyF4lxApt9eg11Low9+wW9b8bZRNoEjnurWNA5YCbyO898FVfsH
	fSYemlJQO4JYBeiJHexoRwTIOPnGG8ItN0eYzT9bPDlSRIwIO/xqWIQoeJwu
X-Google-Smtp-Source: AGHT+IH1iSIW8tE7MXXxHa/57KnS/Lmd07nGqvUn6eNvWbO/QJqnmGXF3ACOh9GXNQrwbcz/E3BYWw==
X-Received: by 2002:a17:906:1c4b:b0:a6f:b940:fc with SMTP id a640c23a62f3a-a6fb94002ffmr329388366b.3.1718978728794;
        Fri, 21 Jun 2024 07:05:28 -0700 (PDT)
Received: from ?IPV6:2001:a61:2b9d:3301:4e5:b71d:160d:fb07? ([2001:a61:2b9d:3301:4e5:b71d:160d:fb07])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf549443sm88170966b.138.2024.06.21.07.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 07:05:28 -0700 (PDT)
Message-ID: <82da9ad9-6a79-4edf-b38f-ef000b68c50a@gmail.com>
Date: Fri, 21 Jun 2024 16:05:27 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10.0-rc2] kernel/module: avoid panic on loading broken
 module
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <230772fc-1076-4afb-8f7a-e7c402548c3b@gmail.com>
 <ZnHm-5oljP8_5dFB@bombadil.infradead.org>
From: Daniel von Kirschten <danielkirschten@gmail.com>
In-Reply-To: <ZnHm-5oljP8_5dFB@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 18.06.2024 um 21:58 schrieb Luis Chamberlain:
> On Thu, Jun 06, 2024 at 03:31:49PM +0200, Daniel v. Kirschten wrote:
>> If a module is being loaded, and the .gnu.linkonce.this_module section
>> in the module's ELF file does not have the WRITE flag, the kernel will
>> map the finished module struct of that module as read-only.
>> This causes a kernel panic when the struct is written to the first time
>> after it has been marked read-only. Currently this happens in
>> complete_formation in kernel/module/main.c:2765 when the module's state is
>> set to MODULE_STATE_COMING, just after setting up the memory protections.
> 
> How did you find this issue?

In a university course I got the assignment to manually craft a loadable 
.ko file, given only a regular object file, without using Kbuild. During 
testing my module files, most of them were simply (correctly) rejected 
by the kernel with an appropriate error message, but at some point I ran 
into this exact kernel panic, and investigated it to understand why my 
module file was invalid.

> 
>> Down the line, this seems to lead to unpredictable freezes when trying to
>> load other modules - I guess this is due to some structures not being
>> cleaned up properly, but I didn't investigate this further.
>>
>> A check already exists which verifies that .gnu.linkonce.this_module
>> is ALLOC. This patch simply adds an analogous check for WRITE.
> 
> Can you check to ensure our modules generated have a respective check to
> ensure this check exists at build time? That would proactively inform
> userspace when a built module is not built correctly, and the tool
> responsible can be identified.

See above - I don't think it's possible to create such a broken module 
file with any of "official" tools. I haven't looked too deeply into how 
Kbuild actually builds modules, but as far as I know, the user doesn't 
even come into contact with this_module when using the regular 
toolchain, because Kbuild is responsible for creating the .this_module 
section. And Kbuild of course creates it with the correct flags. So if I 
understand correctly, this problem can only occur when the module was 
built by some external tooling (or manually, in my case).

   Daniel

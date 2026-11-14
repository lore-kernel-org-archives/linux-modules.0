Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794637264;
	b=WBEn6LKGPq2PeSVzUEaQbAGdIAD5irGX1gUAYNX00+3vIwp+6A5e/mDF/c3nJc+K9AAR
	 /shBMZHpOfROoS+QACjPbUEaQfQSZP/A9yUhPBTpYTAoQoL0CgXwqs5bned7Ae9fhP39r
	 KMVXNGs71pd1yx8fycfQUXrdEhLh0fSZGtZnqti379IiULp0IcMSrqUfn3Ayr85y7r8dX
	 DiOtEJJ5PQitQlZ+GAuiU+thsZ6G6Eu+lNdl4WXpfaXTNlUjDPdAioqW0+aOOVH3niSCj
	 kE13hOgXYgcxB0kpJpaj5iU79RRiKzPbp+UlR9ecrXzdDcF+7022K6gAi2ki55j9DWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794637264;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ARNh6M8BDjbpM7F6J0VTpKzC/Jdg+gIrVCT+UL6skDU=;
	b=d6e6AtN3TSLDuWA2dUcU2tKieabBgTSWc2y5jRFXa8N4gNQzVQeH7vKdLGZSFXnSS/yL
	 39YUXBcA2qMXdRUP6oEslZnJflSC347aU/ugTWP9VHkiNMt7ab8z7gO5kjcrcse0RE/rO
	 9XylQcUArXEXq06GQikkZnajdT71qqRKI6uZV2+404sWRO21LIRxNgadYQMZLp71QLE5S
	 Fcvw2bjbDkbc+YRHr3jzB2b0YuhjiojlDi4HbzVQs1mFfgvXGtJvTUkJcS+7glTE8kNIk
	 /3Olu1XFow3eEkthm5cO4B1rPu+M+PGVRxHzU8RowaKH3u49p0KljAIsCrMJ98mgYqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=V6T4mpP+;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B100F606A32D;
	Sat, 14 Nov 2026 06:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B100F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=V6T4mpP+
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 74D6F40E01DD;
	Sat, 14 Nov 2026 06:21:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KIGF8vHmzNlh; Sat, 14 Nov 2026 06:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794637257; bh=ARNh6M8BDjbpM7F6J0VTpKzC/Jdg+gIrVCT+UL6skDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6T4mpP+7ZYPikg9hdaHn9RdG/8on/u+gqSnKVYN9I8Gt6n/TluzR2GmXxbfUIY8o
	 LwFMyyHlNeapq3hNZZunGJ7j0KAzMMWL5KzVolzm/jWgYLWn5BK2fmewGFleEXKWgS
	 Wghvri2gwjxeg2y7c1SVrbsBh5KiQmZ5WsgKSTeqZwRK6D9hS+5SLQ7hdKAKul8JpA
	 NuwE/3uHDLlSPdbELnXxGabxJAU6IZNZsVCqVEiwzXO7BVmPf/C6HSx5O8YSQ/SDGB
	 WkxLnpQ5CCc2RIowjndXzGqaUqwgsuN+HzuJgtZdY7kAoRsWUq2gIqCGmUlGt9cKN8
	 wwwzTZSR1DGafhCWG8m+nJ4rxEWlOPriwI5L8R+oPejrWf6F0DKHq9T/+xdbSJvKad
	 Om5JRtkv3dvXiElPAbHWSjMXN1FuLi7es8Kp2epIH4EXQpCbacx3cQCkKh7dwna7z1
	 YHABN/NBOejo7dORoBDlZypdtFfeE3NCtnEJhwW8CYomzr8f2fodKlK+XZ8ZbwVqwr
	 YUBipMxCIWTZN0YZ1UDNqcd8p548eJ6PkCW4b2HRmXQMfKJNttYGzNcfBf9UasdF98
	 KVpR/b6+LWHWOJZkflt8Gi0qHhBRcqfHzK/hH764Fvg4Od+SPDqAUl5AcP6G9q+ilV
	 Hi8RriNvVPALN4CMbYxl0iPQ=
Received: from stx.tnic (unknown [209.52.143.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C6CD40E019C;
	Sat, 14 Nov 2026 06:20:45 +0000 (UTC)
Date: Fri, 13 Nov 2026 22:20:42 -0800
From: Borislav Petkov <bp@alien8.de>
To: Guikun Yang <yangguikun19@qq.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Bug report] x86-64 apply_returns() decodes attacker-controlled
 addresses from unvalidated .return_sites entries - wild read on module load
Message-ID: <20261114062042.GAavf9ui9D9bThqdYy@fat_crate.local>
References: <mod-r-offset-oob-20261113@qq.com>
 <srcu-struct-ptrs-wildwrite-20261114@qq.com>
 <tencent_4AF4D4976F851143A745D39A286A1FC2A807@qq.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_4AF4D4976F851143A745D39A286A1FC2A807@qq.com>

On Sat, Nov 14, 2026 at 04:00:00PM +0800, Guikun Yang wrote:
> From: Guikun Yang <yangguikun19@qq.com>
> To: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
>     Ingo Molnar <mingo@redhat.com>,
>     Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
>     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
>     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
>     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
> Subject: [Bug report] x86-64 apply_returns() decodes attacker-controlled
>  addresses from unvalidated .return_sites entries - wild read on module load
> 
> Hi Peter, Ingo,
> 
> The .return_sites section of a module is consumed by apply_returns()
> without any validation of the computed addresses. Each entry is an s32
> relative offset whose final value is fully attacker-controlled via the
> R_X86_64_PC32 relocation addend (that relocation path has no overflow

If you can load modules on a system, you've already won.

Why would you even do some silly exploit like that?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

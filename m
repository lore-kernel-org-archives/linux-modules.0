Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2973B1FA171;
	Fri,  3 Jan 2025 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735914006; cv=none; b=oBwaXrZjPlHwSMIMDhCO7gy/7jkjh8GjDNwdeKxqIHcIvCZPuVmCHihExVU/6CXsgWuOsxtQdWPZp+qOVyJUDjfVZoLLY+z3wHBr5N4Zvaj5aS5C/cedbyVhaCgvcag+RX998ZSxdTXEhmhm3j1JgAKQNtWPNTxyaIm5t8FLgEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735914006; c=relaxed/simple;
	bh=xGYx8KQUYRh88PfcTd2X83icK1ce1R0hFTwkdW3f9xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMDiOqraWxu8+bavWHJAF0M3aHqMPlrxeUlbewOWO9rIlnMe05XrQCaKfiY468jFLzADsdQxAS/z6aZAEcsnwlp2hD/a09Bs+ySq8NJCetdIfqdWSfmatLMGKSVrvZHaQnxBaFLi/1dj2fXCWahe3CatO6Bf/P9BNdNWvsS1U0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YPljx0NQ0z9sT8;
	Fri,  3 Jan 2025 15:06:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rrxuhVcRJ5Sy; Fri,  3 Jan 2025 15:06:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YPljw6jQNz9sT7;
	Fri,  3 Jan 2025 15:06:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D42BB8B767;
	Fri,  3 Jan 2025 15:06:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id V7MDq83ezafQ; Fri,  3 Jan 2025 15:06:28 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 56F7D8B763;
	Fri,  3 Jan 2025 15:06:28 +0100 (CET)
Message-ID: <97beceb2-dd87-4b7f-a269-b6612e5557a3@csgroup.eu>
Date: Fri, 3 Jan 2025 15:06:28 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] module: Make .static_call_sites read-only after init
To: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241223093840.29417-1-petr.pavlu@suse.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241223093840.29417-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Petr,

Le 23/12/2024 à 10:37, Petr Pavlu a écrit :
> Section .static_call_sites holds data structures that need to be sorted and
> processed only at module load time. The section is never modified afterwards.
> Make it therefore read-only after module initialization to avoid any
> (non-)accidental modifications.
> 
> Petr Pavlu (3):
>    module: Constify parameters of module_enforce_rwx_sections()
>    module: Add a separate function to mark sections as read-only after
>      init
>    module: Make .static_call_sites read-only after init
> 
>   kernel/module/internal.h   |  7 ++++--
>   kernel/module/main.c       | 18 +++------------
>   kernel/module/strict_rwx.c | 47 ++++++++++++++++++++++++++++++++++++--
>   3 files changed, 53 insertions(+), 19 deletions(-)
> 
> 

We have a problem at the moment with ro_after_init sections, isn't it 
better to fix it before adding new stuff to ro_after_init ?

This series conflicts with my series which aims at fixing up 
ro_after_init handling in modules, see 
https://patchwork.kernel.org/project/linux-modules/cover/cover.1733427536.git.christophe.leroy@csgroup.eu/

I was expecting my series to land in modules-next, do you or Luis plan 
to take it anytime soon ?

Christophe

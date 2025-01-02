Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491FF1DFFC;
	Thu,  2 Jan 2025 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735824004; cv=none; b=QCGFQXeYYxYKXdZE8QAGuuaSHDo5FLrHqUVak5FysT/CIKp6nyDyMjfvc0/wcPDvmNYBNHZAgNxfAjE2/DYI+PRGwssUSAlQvvhTnsNrbBDqhS1e98kS0FvvIECHg2MXxjG8vcpQm7pIZ172knWacPbpnJ0czv6FkW3XiI+WJ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735824004; c=relaxed/simple;
	bh=oswdK+iqHPKIuKoL1c0BGydhTYNhjlsyuoMdW2mutmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUtS6+s0CKKluJTiG50rKIOfYI3PZKTwCYVAqhFlX9DB0ZvabAT0BetHuQoh8AUTe7lW/rxqnMfaK6AO+ggd6/j9Ss2hDC/3WyJsBLRIcRsorfPfqVVFdkkNQQ5OuE7a0CidiUoGreaMN6k4Ow/uLEanVYqNfD1kQMcJlSzr860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YP60q47Ckz9sj4;
	Thu,  2 Jan 2025 13:47:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 64wCqcDNbevN; Thu,  2 Jan 2025 13:47:07 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YP60q2yxjz9sj3;
	Thu,  2 Jan 2025 13:47:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A7EE8B767;
	Thu,  2 Jan 2025 13:47:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id DiKcyc0TnJce; Thu,  2 Jan 2025 13:47:07 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C3D7C8B763;
	Thu,  2 Jan 2025 13:47:06 +0100 (CET)
Message-ID: <2f95fe76-f309-45f2-8023-7793403ed85b@csgroup.eu>
Date: Thu, 2 Jan 2025 13:47:06 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/28] module: Use RCU instead of RCU-sched.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Daniel Gomez <da.gomez@samsung.com>, Luis Chamberlain
 <mcgrof@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sebastian,

Le 20/12/2024 à 18:41, Sebastian Andrzej Siewior a écrit :
> Hi,
> 
> This is an updated version of the inital post after PeterZ made me aware
> that there are users outside of the module directory.
> The goal is replace the mix auf rcu_read_lock(), rcu_read_lock_sched()
> and preempt_disable() with just rcu_read_lock().
> 
> I've splitted it into smaller chunks which can be applied/ reviewed
> independently. I'm just not sure about the cfi patch (28/28) so I added
> just a comment instead.
> 
> v1…v2: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20241205215102.hRywUW2A%40linutronix.de%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cbad0e7f9344a47371a0808dd211fdefd%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638703142988931970%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=a%2FV5g5zRqceJWedAAZJ4zt6XJpZ0Yqm%2BqKPrsItuEXs%3D&reserved=0
>    - Splitted into smaller patches.
>    - Converted all users.
> 

How did you generate that cover letter ?

It should contain the full list of files modified by the series, so that 
I can see if any of them is of interest to me without going into each patch.

This is done automatically when you use 'git format-patch --cover-letter'.

Christophe

Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8D313C9A9;
	Sat,  9 Nov 2024 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731145779; cv=none; b=hZvWNmW8WWAqE4IG8TWY2DaLqdg2XIL28rANUWbnVXTIt+bajTHUZTjnShpVX2ratoPLl4eP5JmqPti9nmdbp52d/dmvkxx9QK4TIWInXuuaqWdDguEq2YNkoF1cZ+/8L6vD3ZcwMVUQDKo1lAcdiBCTecFst1NjJfZwa3KSqDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731145779; c=relaxed/simple;
	bh=lOaQxBEKnDjy7FDiRZAHiq0rS0aT9QBsiWpkqGcwv+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNsmJwai6t/0XZyw+q2FGV5C2PiO7QdhWnQTTDsHTlLZ66whPncSg3bCAT52dtt5njAzglwxKSwfIGoMpIM2wev62DLPCRvPApL1Qt2ft+Tjjq0zNbqVJEAPb7A0hdFY+jnUnfpnJmGnRnAB7ce6aQy/7aeeYAtRh1qm5kJKZjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Xlrcn4sQjz9sSL;
	Sat,  9 Nov 2024 10:49:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LEz9XIkvJ3se; Sat,  9 Nov 2024 10:49:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Xlrcn42JDz9sSK;
	Sat,  9 Nov 2024 10:49:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 79A868B765;
	Sat,  9 Nov 2024 10:49:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id YzJaUQvUSxpB; Sat,  9 Nov 2024 10:49:29 +0100 (CET)
Received: from [192.168.233.57] (unknown [192.168.233.57])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 05DEB8B764;
	Sat,  9 Nov 2024 10:49:28 +0100 (CET)
Message-ID: <5f1cdf77-b6fc-4a1d-9b6f-a578e1c50dd9@csgroup.eu>
Date: Sat, 9 Nov 2024 10:49:28 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 4/4] module: refactor ro_after_init failure path
To: da.gomez@samsung.com, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: "Daniel Gomez (Samsung)" <d+samsung@kruces.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241108-modules-ro_after_init-v3-0-6dd041b588a5@samsung.com>
 <20241108-modules-ro_after_init-v3-4-6dd041b588a5@samsung.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241108-modules-ro_after_init-v3-4-6dd041b588a5@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/11/2024 à 17:12, Daniel Gomez via B4 Relay a écrit :
> [Vous ne recevez pas souvent de courriers de devnull+da.gomez.samsung.com@kernel.org. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Daniel Gomez <da.gomez@samsung.com>
> 
> When ro_after_init fails, we need to unload the module.
> 
> Rename the goto tag to fail_ro_after_init to make it more clear and try
> to check for dependencies, stop the module and call the exit function.
> This allows to unload the module if ro_after_init fails.

Doesn't build:

   CC      kernel/module/main.o
kernel/module/main.c: In function 'do_init_module':
kernel/module/main.c:2626:19: error: 'struct module' has no member named 
'source_list'; did you mean 'bug_list'?
   list_empty(&mod->source_list);
                    ^~~~~~~~~~~
                    bug_list
kernel/module/main.c:2627:2: error: implicit declaration of function 
'try_stop_module'; did you mean 'do_init_module'? 
[-Werror=implicit-function-declaration]
   try_stop_module(mod, 0, &forced);
   ^~~~~~~~~~~~~~~
   do_init_module
kernel/module/main.c:2629:11: error: 'struct module' has no member named 
'exit'; did you mean 'init'?
   if (mod->exit != NULL)
            ^~~~
            init
kernel/module/main.c:2630:8: error: 'struct module' has no member named 
'exit'; did you mean 'init'?
    mod->exit();
         ^~~~
         init



Christophe

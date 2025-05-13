Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426EE2BF982;
	Tue, 13 May 2025 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747160448; cv=none; b=Xf8cM7CfIK+fd2lgFi1bo9FUIGxW2WpNRwQe8Z+vlq14boGJ+kix49U93MH4WjT5FsFBSOtTMo0qeHAwA3W1eLKsayHbfvBCARSloyTsuPHMmoxP3lIZJ8hQbwMvuW/WJWuK2yFWLmhXy1RIkdQyoc5IDHWEmBA/lHXdbjFB8bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747160448; c=relaxed/simple;
	bh=/iOEpJ9iPy0tHhofY6MLd8ikKgiJWDZRu8pdfRHgU5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrMiR92jvB89DXxOTOM1/8mSVfnisgG5SFtJlZC8k/U3fvdiVgiYFpIV1/9YPkd74VFzRn5O8ICifACNv5fZhzOuttHknJUrUN0vrX8anfkatFgjQ/ijCVaVSk+xO6mo1pSFvqH9oJ5zjaLov3KSLhpcgWYdEOLBuxJTkG86D00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4ZxkZ65hvGz9sB5;
	Tue, 13 May 2025 19:51:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T0z2QbPEdpAx; Tue, 13 May 2025 19:51:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4ZxkZ6517Mz9sB2;
	Tue, 13 May 2025 19:51:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A624E8B765;
	Tue, 13 May 2025 19:51:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id gzWKfMy260rW; Tue, 13 May 2025 19:51:58 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DEB268B763;
	Tue, 13 May 2025 19:51:57 +0200 (CEST)
Message-ID: <a4700ad8-1e6d-4f57-b160-e7b6d172ef60@csgroup.eu>
Date: Tue, 13 May 2025 19:51:57 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] params: Add support for static keys
To: Kent Overstreet <kent.overstreet@linux.dev>, linux-kernel@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org
References: <20250510210126.4032840-1-kent.overstreet@linux.dev>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250510210126.4032840-1-kent.overstreet@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 10/05/2025 à 23:01, Kent Overstreet a écrit :
> Static keys can now be a module parameter, e.g.
> 
> module_param_named(foo, foo.key, static_key_t, 0644)
> 
> bcachefs is now using this.
> 
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Daniel Gomez <da.gomez@samsung.com>
> Cc: linux-modules@vger.kernel.org
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>   include/linux/jump_label.h  |  2 ++
>   include/linux/moduleparam.h |  6 ++++++
>   kernel/params.c             | 35 +++++++++++++++++++++++++++++++++++
>   3 files changed, 43 insertions(+)
> 
> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> index fdb79dd1ebd8..0fc9b71db56f 100644
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -107,6 +107,8 @@ struct static_key {
>   #endif	/* CONFIG_JUMP_LABEL */
>   };
>   
> +typedef struct static_key static_key_t;
> +

Please read https://docs.kernel.org/process/coding-style.html#typedefs

I can't see the reason for a new typedef here. If there is a valid 
reason please explain in the commit message.

Christophe

Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAED18C337
	for <linux-modules@vger.kernel.org>; Fri,  7 Mar 2025 00:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741306384; cv=none; b=IxSeypnl3SJeYqhulyUAu89FlaptAS6WFXZqJWLim5+jeHvY8knXLZkqNNH5YocBMGhqh0y7uS2uC1fouW+nMEtvhc3C6wxjUyRfd2nis9huqP/G2Enge8g6qrzgF14F7qFafkXPoRnVR8LceHP7zmq0VTJ+uZo82DSyRQ0maf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741306384; c=relaxed/simple;
	bh=Tenu1ukjY6u+ZkLVEiCAKDnTnxufajsrpXcE5yWz9kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaCd2um2UAaOaWr5ukzHaXfA0IfXh4wHphzVxy3XUT9vPeUx012WhjKd/Febh3ieX4kqHnspQIR5C7MRpfNu34TwDnIcbpMTNDzchzWYWtX7wwD9vBxC0F9L1X4s1yxlugOaU9JiJvsD95gl7iXixAzJk4y9bkvAhRCpLmS/2gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8Sa4cR7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8Sa4cR7"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2240aad70f2so73805ad.0
        for <linux-modules@vger.kernel.org>; Thu, 06 Mar 2025 16:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741306382; x=1741911182; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WNup9EWbC6i8Ta60udEbTUwEbnvvutxKgGcyMFVFThM=;
        b=o8Sa4cR7kqg8BtBRZMbK/EwaVXRDb+4/AQgJsisqokyKRSdBoNzlRA14qjP7yUig+1
         NdXnx2CQb9CrZFwQuup8cZrMO4BY2LLiE9rzB5Cz2KwIPPK0xquaBPXRUPIHUIuvy5em
         Tk65EDJzOvJF0PtsaPx0LdECH1VJK8DwYyu5dm3Wl1b5hhI5yC8rm7atRtS8DGoOk3a9
         3CaAhX74mMWgw59Pom8R5tyBGXy/qYgY40FNt1o2MvCwLZGh9BLZweHuZTfqevxHaAvI
         gCdAC1smToYk3Jop/J5rYBlvZC6gu6cwm+rE1qhPTOq/sBzpNVQkqr7e4baEGq4XRoga
         o2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741306382; x=1741911182;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNup9EWbC6i8Ta60udEbTUwEbnvvutxKgGcyMFVFThM=;
        b=kFV1kucJhBieiQoAV3V6v4fvvkT1L8GHvTcRrEMb0ZVmZyhZNowW1gsyoi0b6rxbBs
         6GYnPEui9K3ABb/oK+M4N2R0zUHgqVkD8IvxcFZTtQ0DLbajGxrsd//yJPpvizi319JQ
         6LC2zQXglmHVSzdLIaqmLA475tPbMBZFEFbkJhScWcphFT+L3aYJ9KkM1agIw9jHO2L8
         xvfk8Vi/zw3out2qcxAyMr8H16RjEBwlbxsAjMQmgXOYm3W2xh9ct/PFpR+S1OEW4iU2
         +nj5IamNKCs3uZBpLQBM1Xg95GSzbvONdjXfxTEL8GzgN7KPOgAPBiO1KKxPGF7xtbgg
         0Sbg==
X-Forwarded-Encrypted: i=1; AJvYcCUbKNxBCqWZqpmxpKM0gNl5PAPs7JoQ6y5gb3Ap1ayhz7f49l3HqVkDagRQzJ583fHyeyeBWuMexwXvhnrB@vger.kernel.org
X-Gm-Message-State: AOJu0YwbWGZygDQzRFc+3dspwfpGOHcbqf/veh/sgZJlfFgvkHB4V9BR
	G4UWAhEba/Q36FfET19ggM4zveREMuH3YynkcqvLRXOSdX6M+t/Nms6m8d6z1g==
X-Gm-Gg: ASbGnctF7wqlc9DYDBBAGIS0v8kjdZY0sYfVc2L12hOLlZ+zpOxXSJiNW8gzcr0CJ04
	yFkVx9hH2LCIWHnVTJlTVEVq4yYTIkdlc5wMm0FIwhgPywpD2mo2Oj+bY4CIAKA+pteybFwrPmA
	4Co0GNMIU7Ncdk/RLU05iD1rRfzDGCs1nmBkNBclWRTphZl/i4JDEYSVxCE/SO1U6sEjHZO+teC
	zdpUHZF61qwAGL5OBUKDkUC7Byy5P6x93svaKKSixr4AnRpeURyZIguYTJnpz5YRUgnZro03qc2
	wrwemQOMm/KG3VXQb5pDxqYymm7o4D8+RACnzHV22n1MFyBWKdeYDN73+WzewO1NQaif3wEsjPg
	+m/xg6R/RLFQzZzg=
X-Google-Smtp-Source: AGHT+IGndUGgbQJfPfDEt+Vg5y1zSKAlbfktDO3mZC256dapXXCz6DYdZT7vrdjQcup5ZikrLodZnw==
X-Received: by 2002:a17:903:22c8:b0:215:65f3:27ef with SMTP id d9443c01a7336-2242971d35amr1149525ad.12.1741306382090;
        Thu, 06 Mar 2025 16:13:02 -0800 (PST)
Received: from google.com (227.180.227.35.bc.googleusercontent.com. [35.227.180.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693f7cebsm1864500a91.45.2025.03.06.16.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 16:13:01 -0800 (PST)
Date: Fri, 7 Mar 2025 00:12:56 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] module: Make .static_call_sites read-only after
 init
Message-ID: <20250307001256.GA2276503@google.com>
References: <20250306131430.7016-1-petr.pavlu@suse.com>
 <20250306131430.7016-4-petr.pavlu@suse.com>
 <481a3ef9-6d4e-4e29-9d50-a6338604c873@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <481a3ef9-6d4e-4e29-9d50-a6338604c873@csgroup.eu>

On Thu, Mar 06, 2025 at 06:28:58PM +0100, Christophe Leroy wrote:
> 
> 
> Le 06/03/2025 à 14:13, Petr Pavlu a écrit :
> > Section .static_call_sites holds data structures that need to be sorted and
> > processed only at module load time. This initial processing happens in
> > static_call_add_module(), which is invoked as a callback to the
> > MODULE_STATE_COMING notification from prepare_coming_module().
> > 
> > The section is never modified afterwards. Make it therefore read-only after
> > module initialization to avoid any (non-)accidental modifications.
> 
> Maybe this suggestion is stupid, I didn't investigate the feasability but:
> why don't we group everything that is ro_after_init in a single section just
> like we do in vmlinux ? That would avoid having to add every new possible
> section in the C code.
> 
> Like we have in asm-generic/vmlinux.lds.h:
> 
> #define RO_AFTER_INIT_DATA						\
> 	. = ALIGN(8);							\
> 	__start_ro_after_init = .;					\
> 	*(.data..ro_after_init)						\
> 	JUMP_TABLE_DATA							\
> 	STATIC_CALL_DATA						\
> 	__end_ro_after_init = .;

I like this idea. Grouping the sections in the module linker script
feels cleaner than having an array of section names in the code. To be
fair, I think this code predates v5.10, where scripts/module.lds.S was
first added.

Sami

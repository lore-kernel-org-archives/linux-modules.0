Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D19D2EB
	for <linux-modules@vger.kernel.org>; Tue,  3 Oct 2023 21:08:39 +0000 (UTC)
Received: from attila.bofh.it (attila.bofh.it [85.94.204.146])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA352AB
	for <linux-modules@vger.kernel.org>; Tue,  3 Oct 2023 14:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.it;
 i=@linux.it; q=dns/txt; s=attila; t=1696367314; h=date : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to : from : from;
 bh=cvrNXZOi6dy8ejjGXtIcqRsT1I0Z0PJo+n2Hf0Np2Lk=;
 b=Vpc5j5354OqTZ1Swd1Z9r2uoSCC3NE6rUQ5Uz++nkwf6/6eKd+FCeEHGySXTn0iL8f4L7
 ajUM+fe9VQBBQWjCzE+KkLkEPglcR948SeAA+5+WgNn55BtFA0Q5nmyKIUwBaGQQZ5LBT7a
 0jFNqNdzSOwNxvd17KoMCjesuNEfSmY=
Received: by attila.bofh.it (Postfix, from userid 10)
	id 8EB3C17C08C9; Tue,  3 Oct 2023 23:08:34 +0200 (CEST)
Received: by bongo.bofh.it (Postfix, from userid 1000)
	id 34B41522B24; Tue,  3 Oct 2023 23:08:29 +0200 (CEST)
Date: Tue, 3 Oct 2023 23:08:29 +0200
To: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
Cc: linux-modules@vger.kernel.org
Subject: Re: Unbootable system with kmod-31
Message-ID: <ZRyCzQ67pAlbNOYa@bongo.bofh.it>
Mail-Followup-To: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>,
	linux-modules@vger.kernel.org
References: <acf37f00-cea3-4f77-9c05-3c0301221d2a@moonlit-rail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acf37f00-cea3-4f77-9c05-3c0301221d2a@moonlit-rail.com>
From: Marco d'Itri <md@Linux.IT>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_NEUTRAL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Oct 03, "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com> wrote:

> I upgraded from kmod-30 to kmod-31, and could not boot due to an
> inability to load any module.  Any invocation of insmod bombs with,
> "decompression failed with status 6".  I strace'd the issue to the
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1050586

-- 
ciao,
Marco

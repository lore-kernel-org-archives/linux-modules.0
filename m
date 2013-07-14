Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:47589 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210Ab3GNNC7 (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Sun, 14 Jul 2013 09:02:59 -0400
Received: by mail-bk0-f45.google.com with SMTP id je9so4203893bkc.4
        for <linux-modules@vger.kernel.org>; Sun, 14 Jul 2013 06:02:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130714122945.GB558@rampage>
References: <1373802978-12456-1-git-send-email-teg@jklm.no> <20130714122945.GB558@rampage>
From: Tom Gundersen <teg@jklm.no>
Date: Sun, 14 Jul 2013 15:02:37 +0200
Message-ID: <CAG-2HqV5iA-kGpcKY8DLCgVPY6sC7F_oo=FxXvwGHibQknovtg@mail.gmail.com>
Subject: Re: [PATCH 1/2] static-nodes: don't fail if modules.devname not found
To: Tom Gundersen <teg@jklm.no>, linux-modules@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Sun, Jul 14, 2013 at 2:29 PM, Dave Reisner <d@falconindy.com> wrote:
> On Sun, Jul 14, 2013 at 01:56:17PM +0200, Tom Gundersen wrote:
>> +                     strncpy(output, optarg, PATH_MAX);
>
> No need to copy anything here, just retain a pointer to this optarg.

Fixed.

>> +     if (out == NULL) {
>
> It took me a minute to realize why this was the correct comparison.
> Maybe it's just me, but I think this would be more readable if we did
> something like the below psuedocode
>
>   const char* output = "/dev/stderr";
>   /* do option parsing, maybe reassigning 'output' */
>
>   /* now open the file, regardless of what it is */
>   FILE* out = fopen(output, "we");
>   if (out == NULL)
>     ...
>
> Seems a bit cleaner to me, even if it duplicates a file descriptor (but
> we'll open a new FILE regardless in the common use case).

Yeah, makes sense to me, I'll do that instead.

>> +             out = fopen(output, "we");
>> +             if (out == NULL) {
>> +                     fprintf(stderr, "Error: could not create %s!\n",
>> +                             output);
>
> I realize this is copied from the old code, but there's no explanation
> as to why this failed. Add an %m token to the format string?

For some reason that change ended up in the subsequent patch, anyway,
moving it to this one where it belong.

Thanks.

Tom

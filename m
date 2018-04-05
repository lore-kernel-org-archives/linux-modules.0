MIME-Version: 1.0
In-Reply-To: <20180307105121.18634-1-luca.bruno@coreos.com>
References: <20180307105121.18634-1-luca.bruno@coreos.com>
Date: Thu, 5 Apr 2018 14:55:46 -0700
Message-ID: <CAKi4VA+0xNzFbRdisg3ZeNrdciYEy_Bb=Lu2tm3TL8HN-Jdgtw@mail.gmail.com>
Subject: Re: [PATCH] libkmod-module: check for NULL before accessing pointers
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Luca Bruno <luca.bruno@coreos.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Wed, Mar 7, 2018 at 2:51 AM, Luca Bruno <luca.bruno@coreos.com> wrote:
> This introduces a few missing NULL-checks in public functions, and
> align their docstrings with real behavior by getting rid of copy-paste
> mistakes.
>
> Signed-off-by: Luca Bruno <luca.bruno@coreos.com>
> ---

Applied, thanks

Lucas De Marchi

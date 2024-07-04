<?php

namespace App\Filters;

use App\Models\SearchDeclaration;
use CodeIgniter\Filters\FilterInterface;
use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;

/**
 * Verify if the user is logged
 */
class CommonFilter implements FilterInterface
{
    public function before(RequestInterface $request, $arguments = null)
    {
        if (!isset($_SESSION["searchDeclaration"])) {
            $_SESSION["searchDeclaration"] = new SearchDeclaration();
        }
    }

    public function after(RequestInterface $request, ResponseInterface $response, $arguments = null)
    {
    }
}
